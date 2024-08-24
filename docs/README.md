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

The package format of LPkg is fairly straight-forward. The basic structure has a header, payload, and footer. The header
of the source and binary package file format is organized like so:

*Figure 1: Header Format for Source and Binary Files:*

| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header which informs tools what the file type is and the version of the package format with a null terminator ending the section |
| 1 | ToC | The table of contents of the file. This is stored as a base64 encoded JSON string with a null terminator at the end of the section |
| 2 | Metadata | A base64 encoded JSON representation of the package's metadata with a null terminator at the end of the section |
| 3 | Checksum | A base64 encoded JSON representation of the SHA512 checksum of the payload content with a null terminator at the end of the section |
| 4 | Payload | The base64 encoded payload of the package. This is in GNU tar format compressed using the bzip2 compression algorithm. Again like other sections, it is null terminated |
| 5 | Signature | The GPG signatures used to certify that the package was built by the organisations or people that are trusted to have supplied or built the package |

*Figure 2: Header Format for Meta Packages*

| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Stored in hexidecimal with a null terminator |
| 1 | ToC | The table of contents of the file. Far more abridged as there is only the two "content" sections of the file compared to the other formats. Base64 encoded and null terminated |
| 2 | Metadata | A base64 encoded JSON containing all the metadata required to detail the other packages being required by the meta package |
| 3 | Signature | The GPG signatures used to certify that the package was built by the organisations or people that are trusted to have supplied or built the package |

*Figure 3: Header Format for Bundle Packages*

| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Stored in hexidecimal with a null terminator |
| 1 | ToC | The table of contents of the file. As before, JSON data with base64 encoding and null terminated |
| 2 | Metadata | A base64 encoded JSON containing the bundle metadata. This does not contain the metadata from the bundled packages in the bundle package |
| 3 | Checksum | A base64 encoded JSON with the SHA512 checksums of the GNU tar archive payload. Terminated by a null terminator |
| 4 | Payload | This section contains more than one base64 encoded bundled package bundled in a GNU tar archive. The tar archive is null terminated to denote the end of the payload section |
| 5 | Signature | The GPG signatures used to certify that the package was built by the organisations or people that are trusted to have supplied or built the package |

*Figure 4: Header Format for Source Packages*

| Position | Section | Description |
| --- | --- | --- |
| 0 | Magic | The "magic number" section of the header. Terminated with a null terminator |
| 1 | ToC | The table of contents of the file. Again, JSON data in base64 encoding and null terminated |
| 2 | Metadata | A base64 encoded JSON representing the metadata about the source package. This does not contain the metadata for any to-be-built sub packages that the source package can create. Null terminated |
| 3 | Checksum | A base64 encoded JSON representation of the checksum of the file. The hash used is SHA512. Terminated with a null terminator |
| 4 | Payload | This section contains the blueprint file, any patches needed for properly building the package, and any sources needed in a GNU tar bzip2 archive. The section is null terminated to denote the end of the payload section |
| 5 | Signature | The GPG signatures used to certify that the package was created by the organisations or people that are trusted to have supplied or built the package |

### Magic Format

The Magic section allows tools to determine the type and architecture of the binary file.

### Table of Contents JSON Format

The JSON structure of the table-of-contents is organized like so:

*Figure 5: Table of Contents Keys and Structures:*

| Key | Type | Description |
| --- | --- | --- |
| `$schema` | string | JSON schema definition |
| `type` | number | An integer constant to denote the type of package the ToC represents. The enum list for this is defined below |
| `arch` | number | An integer constant to denote the platform architecture the package can be installed on |
| `version` | string | The version of the ToC format. Current format is 1.0.0. This uses semver versioning |
| `sections` | object | The object that holds the ToC data |

*Figure 6: Type Enum*

| Number | Represented Value |
| --- | --- |
| 1 | Meta Package |
| 2 | Single-payload binary package |
| 3 | Multi-payload bundle package |
| 4 | Source package |

*Figure 7: Architecture Enum*

| Number | Represented Value |
| --- | --- |
| 1 | noarch |
| 2 | ia32 |
| 3 | x86_64 |
| 4 | aarch64 |

*Figure 8: The `sections` Object*

| Key | Type | Description |
| --- | --- | --- |
| `metadata` | object | The JSON object describing the start and end location of the Metadata section of the file |
| `checksum` | object | The JSON object describing the start and end location of the Checksum section of the file, if it contains one |
| `payload` | object | The JSON object describing the start and end location of the Payload section of the file, if it contains one |
| `signatures` | object | The JSON object describing the start and end location of the Signature section of the file |

*Figure 9: The `metadata` Object*

| Key | Type | Description |
| --- | --- | --- |
