# LPkgTools

## Introduction

This document covers the overall technical design for the LPkgTools and file formats used by LPkg. This includes the
internal structures of the produced files and the logic flow of how the files are created and installed and or
uninstalled from a system either using the tools delivered as part of LPkgTools or related tools as part of the InstallD
or SoftwareMetadataD system daemons and user client tooling.

## Rationale

Foundationally, the reason for creating a brand new package format and manager for Linux stems from the need for a mix
of the features from both DPKG and RPM. Where DPKG has arguably better handling of different types of dependencies
(critical, recommends, requires, and suggests) and RPM is, again arguably simpler to create packages with. In addition,
LPkg aims to add proper support for other binary package types, such as meta packages and bundles. Neither of which DPKG
or RPM really natively support.

## Package Format

The package format of LPkg is fairly straight-forward. The basic structure has a header, payload, and footer.

- The header contains the various bits of metadata for the package
- The payload contains the content archived in the package
- The footer of the package contains the GPG signatures for the package

The header of the source and binary package file format is organized like so:

*Figure 1: Header Format for Source and Binary Files:*
| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header which informs tools what the file type is and the version of the package format with a null terminator ending the section |
| 1 | ToC | The table of contents of the file. This is stored as a base64 encoded JSON string with a null terminator at the end of the section |
| 2 | Metadata | A base64 encoded JSON representation of the package's metadata with a null terminator at the end of the section |
| 3 | Checksum | A base64 encoded JSON representation of the SHA512 checksum of the payload content with a null terminator at the end of the section |

*Figure 2: Header Format for Meta Packages:*
| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Stored in hexidecimal with a null terminator |
| 1 | ToC | The table of contents of the file. Far more abridged as there is only the two "content" sections of the file compared to the other formats. Base64 encoded and null terminated |
| 2 | Metadata | A base64 encoded JSON containing all the metadata required to detail the other packages being required by the meta package |

*Figure 3: Header Format for Bundle Packages:*
| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Stored in hexidecimal with a null terminator |
| 1 | ToC | The table of contents of the file. As before, JSON data with base64 encoding and null terminated |
| 2 | Metadata | A base64 encoded JSON containing the bundle metadata. This does not contain the metadata from the bundled packages in the bundle package |
| 3 | Checksum | A base64 encoded JSON with the SHA512 checksums of the GNU tar archive payload. Terminated by a null terminator |

*Figure 4: Header Format for Source Packages:*
| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Terminated with a null terminator |
| 1 | ToC | The table of contents of the file. Again, JSON data in base64 encoding and null terminated |
| 2 | Metadata | A base64 encoded JSON representing the metadata about the source package. This does not contain the metadata for any to-be-built sub packages that the source package can create. Null terminated |
| 3 | Checksum | A base64 encoded JSON representation of the checksum of the file. The hash used is SHA512. Terminated with a null terminator |

### Magic Format

The Magic section allows tools to determine the type and architecture of the binary file. The current magic format in use by LPkg is shown in the table below. The structure of the hexidecimal encoded string is `lpkg:v$VERSION_INT:t$TYPE_ENUM:a$ARCH_ENUM` with colon seperated sections. The leading "lpkg" literal is to clearly denote that this is an archive format for use by LPkgTools and other compatible tools. The `v$VERSION_INT` denotes the version of the file type. The `t$TYPE_ENUM` denotes the type of package, whether binary, meta, bundle, or source. Finally, the `a$ARCH_ENUM` denotes the architecture that the package will install onto.

*Figure 5: Magic Format per Package Type Example:*
| Hex String | ASCII String | Description |
| --- | --- | --- |
| 0x6c706b673a76313a74613a6131 | lpkg:v1:t2:a1 | An LPkg v1 single-payload binary package for the noarch (installable on all architectures) systems |

### Table of Contents JSON Format

The JSON structure of the table-of-contents is organized like so:

*Figure 6: Table of Contents Keys and Structures:*
| Key | Type | Description |
| --- | --- | --- |
| `$schema` | string | JSON schema definition |
| `type` | number | An integer constant to denote the type of package the ToC represents. The enum list for this is defined below |
| `arch` | number | An integer constant to denote the platform architecture the package can be installed on |
| `version` | string | The version of the ToC format. Current format is 1.0.0. This uses semver versioning |
| `sections` | object | The object that holds the ToC data |

*Figure 7: Type Enum:*
| Number | Represented Value |
| --- | --- |
| 1 | Meta Package |
| 2 | Single-payload binary package |
| 3 | Multi-payload bundle package |
| 4 | Source package |

*Figure 8: Architecture Enum:*
| Number | Represented Value |
| --- | --- |
| 1 | noarch |
| 2 | ia32 |
| 3 | x86_64 |
| 4 | aarch64 |

*Figure 9: The `sections` Object:*
| Key | Type | Mandatory | Description |
| --- | --- | --- | --- |
| `metadata` | object | true | The JSON object describing the start and end location of the Metadata section of the file |
| `checksum` | object | false | The JSON object describing the start and end location of the Checksum section of the file, if it contains one |
| `payload` | object | false | The JSON object describing the start and end location of the Payload section of the file, if it contains one |
| `signatures` | object | true | The JSON object describing the start and end location of the Signature section of the file |

*Figure 10: The `metadata` Object:*
| Key | Type | Description |
| --- | --- | --- |
| `start` | integer | Start of the metadata section |
| `end` | integer | End of the metadata section. This is the byte count before the null terminator |

*Figure 11: The `checksum` Object:*
| Key | Type | Description |
| --- | --- | --- |
| `start` | integer | Start of the checksum section |
| `end` | integer | End of the checksum section. This is the byte count before the null terminator |

*Figure 12: The `payload` Object:*
| Key | Type | Description |
| --- | --- | --- |
| `start` | integer | Start of the payload section |
| `end` | integer | End of the payload section. This is the byte count before the null terminator |

*Figure 13: The `signatures` Object:*
| Key | Type | Description |
| --- | --- | --- |
| `start` | integer | Start of the signatures section |
| `end` | integer | End of the signatures section. This is the byte count before the null terminator |

*Figure 14: An example ToC JSON for a single payload binary x86_64 package:* *
```json
{
    "$schema": "http://www.altimatos.org/standards/lpkg-toc.schema.json",
    "version": "1.0.0",
    "type": 2,
    "arch": 3,
    "sections": {
        "metadata": {
            "start": 512,
            "end": 1024
        },
        "checksum": {
            "start": 1026,
            "end": 1200
        },
        "payload": {
            "start": 1202,
            "end": 10501
        },
        "signatures": {
            "start": 10503,
            "end": 10600
        }
    }
}
```

*Note: numbers in example are not accurate

### Metadata Section