--
-- File generated with SQLiteStudio v3.4.4 on Mon Aug 12 21:33:02 2024
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Architectures
DROP TABLE IF EXISTS Architectures;

CREATE TABLE IF NOT EXISTS Architectures (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT
                 UNIQUE
                 NOT NULL,
    Name STRING  UNIQUE
                 NOT NULL
);

INSERT INTO Architectures (
                              Id,
                              Name
                          )
                          VALUES (
                              1,
                              'x86_64'
                          );

INSERT INTO Architectures (
                              Id,
                              Name
                          )
                          VALUES (
                              2,
                              'ia32'
                          );

INSERT INTO Architectures (
                              Id,
                              Name
                          )
                          VALUES (
                              3,
                              'aarch64'
                          );

INSERT INTO Architectures (
                              Id,
                              Name
                          )
                          VALUES (
                              4,
                              'noarch'
                          );


-- Table: DependencyTypes
DROP TABLE IF EXISTS DependencyTypes;

CREATE TABLE IF NOT EXISTS DependencyTypes (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT
                 NOT NULL
                 UNIQUE,
    Type STRING  UNIQUE
                 NOT NULL
);

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                1,
                                'capability'
                            );

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                2,
                                'group'
                            );

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                3,
                                'user'
                            );

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                4,
                                'directory'
                            );

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                5,
                                'file'
                            );

INSERT INTO DependencyTypes (
                                Id,
                                Type
                            )
                            VALUES (
                                6,
                                'pkg'
                            );


-- Table: InstalledPkgs
DROP TABLE IF EXISTS InstalledPkgs;

CREATE TABLE IF NOT EXISTS InstalledPkgs (
    Id           INTEGER  PRIMARY KEY AUTOINCREMENT
                          NOT NULL
                          UNIQUE,
    Name         STRNG    UNIQUE
                          NOT NULL,
    Epoch        INTEGER  NOT NULL
                          DEFAULT (0),
    Version      STRING   UNIQUE
                          NOT NULL,
    License      INTEGER  NOT NULL
                          REFERENCES Licenses (Id),
    Summary      STRING   NOT NULL,
    Description  TEXT     NOT NULL,
    Section      STRING   NOT NULL,
    Architecture INTEGER  NOT NULL
                          REFERENCES Architectures (Id),
    SrcUrl       STRING   NOT NULL,
    PkgType      INTEGER  REFERENCES PkgTypes (Id) 
                          NOT NULL,
    BuildHost    STRING   NOT NULL,
    BuildDate    DATETIME NOT NULL
                          DEFAULT (CURRENT_TIMESTAMP) 
);


-- Table: Licenses
DROP TABLE IF EXISTS Licenses;

CREATE TABLE IF NOT EXISTS Licenses (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT
                 UNIQUE
                 NOT NULL,
    Name STRING  UNIQUE
                 NOT NULL
);

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         1,
                         '0bsd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         2,
                         '3d-slicer-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         3,
                         'aal'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         4,
                         'abstyles'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         5,
                         'adacore-doc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         6,
                         'adobe-2006'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         7,
                         'adobe-display-postscript'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         8,
                         'adobe-glyph'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         9,
                         'adobe-utopia'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         10,
                         'adsl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         11,
                         'afl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         12,
                         'afl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         13,
                         'afl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         14,
                         'afl-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         15,
                         'afl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         16,
                         'afmparse'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         17,
                         'agpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         18,
                         'agpl-1.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         19,
                         'agpl-1.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         20,
                         'agpl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         21,
                         'agpl-3.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         22,
                         'agpl-3.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         23,
                         'aladdin'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         24,
                         'amd-newlib'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         25,
                         'amdplpa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         26,
                         'aml'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         27,
                         'aml-glslang'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         28,
                         'ampas'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         29,
                         'antlr-pd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         30,
                         'antlr-pd-fallback'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         31,
                         'any-osi'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         32,
                         'apache-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         33,
                         'apache-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         34,
                         'apache-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         35,
                         'apafml'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         36,
                         'apl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         37,
                         'app-s2p'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         38,
                         'apsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         39,
                         'apsl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         40,
                         'apsl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         41,
                         'apsl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         42,
                         'arphic-1999'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         43,
                         'artistic-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         44,
                         'artistic-1.0-cl8'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         45,
                         'artistic-1.0-perl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         46,
                         'artistic-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         47,
                         'aswf-digital-assets-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         48,
                         'aswf-digital-assets-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         49,
                         'baekmuk'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         50,
                         'bahyph'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         51,
                         'barr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         52,
                         'bcrypt-solar-designer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         53,
                         'beerware'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         54,
                         'bitstream-charter'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         55,
                         'bitstream-vera'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         56,
                         'bittorrent-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         57,
                         'bittorrent-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         58,
                         'blessing'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         59,
                         'blueoak-1.0.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         60,
                         'boehm-gc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         61,
                         'borceux'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         62,
                         'brian-gladman-2-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         63,
                         'brian-gladman-3-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         64,
                         'bsd-1-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         65,
                         'bsd-2-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         66,
                         'bsd-2-clause-darwin'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         67,
                         'bsd-2-clause-first-lines'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         68,
                         'bsd-2-clause-freebsd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         69,
                         'bsd-2-clause-netbsd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         70,
                         'bsd-2-clause-patent'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         71,
                         'bsd-2-clause-views'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         72,
                         'bsd-3-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         73,
                         'bsd-3-clause-acpica'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         74,
                         'bsd-3-clause-attribution'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         75,
                         'bsd-3-clause-clear'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         76,
                         'bsd-3-clause-flex'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         77,
                         'bsd-3-clause-hp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         78,
                         'bsd-3-clause-lbnl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         79,
                         'bsd-3-clause-modification'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         80,
                         'bsd-3-clause-no-military-license'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         81,
                         'bsd-3-clause-no-nuclear-license'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         82,
                         'bsd-3-clause-no-nuclear-license-2014'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         83,
                         'bsd-3-clause-no-nuclear-warranty'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         84,
                         'bsd-3-clause-open-mpi'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         85,
                         'bsd-3-clause-sun'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         86,
                         'bsd-4-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         87,
                         'bsd-4-clause-shortened'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         88,
                         'bsd-4-clause-uc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         89,
                         'bsd-4.3reno'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         90,
                         'bsd-4.3tahoe'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         91,
                         'bsd-advertising-acknowledgement'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         92,
                         'bsd-attribution-hpnd-disclaimer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         93,
                         'bsd-inferno-nettverk'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         94,
                         'bsd-protection'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         95,
                         'bsd-source-beginning-file'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         96,
                         'bsd-source-code'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         97,
                         'bsd-systemics'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         98,
                         'bsd-systemics-w3works'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         99,
                         'bsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         100,
                         'busl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         101,
                         'bzip2-1.0.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         102,
                         'bzip2-1.0.6'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         103,
                         'c-uda-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         104,
                         'cal-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         105,
                         'cal-1.0-combined-work-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         106,
                         'caldera'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         107,
                         'caldera-no-preamble'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         108,
                         'catharon'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         109,
                         'catosl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         110,
                         'cc-by-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         111,
                         'cc-by-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         112,
                         'cc-by-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         113,
                         'cc-by-2.5-au'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         114,
                         'cc-by-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         115,
                         'cc-by-3.0-at'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         116,
                         'cc-by-3.0-au'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         117,
                         'cc-by-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         118,
                         'cc-by-3.0-igo'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         119,
                         'cc-by-3.0-nl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         120,
                         'cc-by-3.0-us'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         121,
                         'cc-by-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         122,
                         'cc-by-nc-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         123,
                         'cc-by-nc-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         124,
                         'cc-by-nc-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         125,
                         'cc-by-nc-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         126,
                         'cc-by-nc-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         127,
                         'cc-by-nc-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         128,
                         'cc-by-nc-nd-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         129,
                         'cc-by-nc-nd-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         130,
                         'cc-by-nc-nd-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         131,
                         'cc-by-nc-nd-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         132,
                         'cc-by-nc-nd-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         133,
                         'cc-by-nc-nd-3.0-igo'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         134,
                         'cc-by-nc-nd-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         135,
                         'cc-by-nc-sa-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         136,
                         'cc-by-nc-sa-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         137,
                         'cc-by-nc-sa-2.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         138,
                         'cc-by-nc-sa-2.0-fr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         139,
                         'cc-by-nc-sa-2.0-uk'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         140,
                         'cc-by-nc-sa-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         141,
                         'cc-by-nc-sa-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         142,
                         'cc-by-nc-sa-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         143,
                         'cc-by-nc-sa-3.0-igo'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         144,
                         'cc-by-nc-sa-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         145,
                         'cc-by-nd-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         146,
                         'cc-by-nd-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         147,
                         'cc-by-nd-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         148,
                         'cc-by-nd-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         149,
                         'cc-by-nd-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         150,
                         'cc-by-nd-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         151,
                         'cc-by-sa-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         152,
                         'cc-by-sa-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         153,
                         'cc-by-sa-2.0-uk'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         154,
                         'cc-by-sa-2.1-jp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         155,
                         'cc-by-sa-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         156,
                         'cc-by-sa-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         157,
                         'cc-by-sa-3.0-at'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         158,
                         'cc-by-sa-3.0-de'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         159,
                         'cc-by-sa-3.0-igo'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         160,
                         'cc-by-sa-4.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         161,
                         'cc-pddc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         162,
                         'cc0-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         163,
                         'cddl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         164,
                         'cddl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         165,
                         'cdl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         166,
                         'cdla-permissive-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         167,
                         'cdla-permissive-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         168,
                         'cdla-sharing-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         169,
                         'cecill-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         170,
                         'cecill-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         171,
                         'cecill-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         172,
                         'cecill-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         173,
                         'cecill-b'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         174,
                         'cecill-c'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         175,
                         'cern-ohl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         176,
                         'cern-ohl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         177,
                         'cern-ohl-p-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         178,
                         'cern-ohl-s-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         179,
                         'cern-ohl-w-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         180,
                         'cfitsio'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         181,
                         'check-cvs'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         182,
                         'checkmk'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         183,
                         'clartistic'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         184,
                         'clips'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         185,
                         'cmu-mach'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         186,
                         'cmu-mach-nodoc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         187,
                         'cnri-jython'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         188,
                         'cnri-python'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         189,
                         'cnri-python-gpl-compatible'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         190,
                         'coil-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         191,
                         'community-spec-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         192,
                         'condor-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         193,
                         'copyleft-next-0.3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         194,
                         'copyleft-next-0.3.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         195,
                         'cornell-lossless-jpeg'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         196,
                         'cpal-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         197,
                         'cpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         198,
                         'cpol-1.02'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         199,
                         'cronyx'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         200,
                         'crossword'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         201,
                         'crystalstacker'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         202,
                         'cua-opl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         203,
                         'cube'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         204,
                         'curl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         205,
                         'cve-tou'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         206,
                         'd-fsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         207,
                         'dec-3-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         208,
                         'diffmark'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         209,
                         'dl-de-by-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         210,
                         'dl-de-zero-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         211,
                         'doc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         212,
                         'dotseqn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         213,
                         'drl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         214,
                         'drl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         215,
                         'dsdp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         216,
                         'dtoa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         217,
                         'dvipdfm'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         218,
                         'ecl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         219,
                         'ecl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         220,
                         'ecos-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         221,
                         'efl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         222,
                         'efl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         223,
                         'egenix'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         224,
                         'elastic-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         225,
                         'entessa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         226,
                         'epics'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         227,
                         'epl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         228,
                         'epl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         229,
                         'erlpl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         230,
                         'etalab-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         231,
                         'eudatagrid'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         232,
                         'eupl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         233,
                         'eupl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         234,
                         'eupl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         235,
                         'eurosym'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         236,
                         'fair'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         237,
                         'fbm'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         238,
                         'fdk-aac'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         239,
                         'ferguson-twofish'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         240,
                         'frameworx-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         241,
                         'freebsd-doc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         242,
                         'freeimage'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         243,
                         'fsfap'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         244,
                         'fsfap-no-warranty-disclaimer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         245,
                         'fsful'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         246,
                         'fsfullr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         247,
                         'fsfullrwd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         248,
                         'ftl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         249,
                         'furuseth'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         250,
                         'fwlw'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         251,
                         'gcr-docs'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         252,
                         'gd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         253,
                         'gfdl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         254,
                         'gfdl-1.1-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         255,
                         'gfdl-1.1-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         256,
                         'gfdl-1.1-no-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         257,
                         'gfdl-1.1-no-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         258,
                         'gfdl-1.1-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         259,
                         'gfdl-1.1-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         260,
                         'gfdl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         261,
                         'gfdl-1.2-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         262,
                         'gfdl-1.2-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         263,
                         'gfdl-1.2-no-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         264,
                         'gfdl-1.2-no-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         265,
                         'gfdl-1.2-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         266,
                         'gfdl-1.2-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         267,
                         'gfdl-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         268,
                         'gfdl-1.3-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         269,
                         'gfdl-1.3-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         270,
                         'gfdl-1.3-no-invariants-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         271,
                         'gfdl-1.3-no-invariants-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         272,
                         'gfdl-1.3-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         273,
                         'gfdl-1.3-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         274,
                         'giftware'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         275,
                         'gl2ps'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         276,
                         'glide'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         277,
                         'glulxe'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         278,
                         'glwtpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         279,
                         'gnuplot'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         280,
                         'gpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         281,
                         'gpl-1.0+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         282,
                         'gpl-1.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         283,
                         'gpl-1.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         284,
                         'gpl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         285,
                         'gpl-2.0+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         286,
                         'gpl-2.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         287,
                         'gpl-2.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         288,
                         'gpl-2.0-with-autoconf-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         289,
                         'gpl-2.0-with-bison-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         290,
                         'gpl-2.0-with-classpath-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         291,
                         'gpl-2.0-with-font-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         292,
                         'gpl-2.0-with-gcc-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         293,
                         'gpl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         294,
                         'gpl-3.0+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         295,
                         'gpl-3.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         296,
                         'gpl-3.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         297,
                         'gpl-3.0-with-autoconf-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         298,
                         'gpl-3.0-with-gcc-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         299,
                         'graphics-gems'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         300,
                         'gsoap-1.3b'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         301,
                         'gtkbook'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         302,
                         'gutmann'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         303,
                         'haskellreport'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         304,
                         'hdparm'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         305,
                         'hidapi'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         306,
                         'hippocratic-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         307,
                         'hp-1986'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         308,
                         'hp-1989'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         309,
                         'hpnd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         310,
                         'hpnd-dec'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         311,
                         'hpnd-doc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         312,
                         'hpnd-doc-sell'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         313,
                         'hpnd-export-us'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         314,
                         'hpnd-export-us-acknowledgement'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         315,
                         'hpnd-export-us-modify'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         316,
                         'hpnd-export2-us'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         317,
                         'hpnd-fenneberg-livingston'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         318,
                         'hpnd-inria-imag'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         319,
                         'hpnd-intel'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         320,
                         'hpnd-kevlin-henney'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         321,
                         'hpnd-markus-kuhn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         322,
                         'hpnd-merchantability-variant'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         323,
                         'hpnd-mit-disclaimer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         324,
                         'hpnd-netrek'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         325,
                         'hpnd-pbmplus'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         326,
                         'hpnd-sell-mit-disclaimer-xserver'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         327,
                         'hpnd-sell-regexpr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         328,
                         'hpnd-sell-variant'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         329,
                         'hpnd-sell-variant-mit-disclaimer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         330,
                         'hpnd-sell-variant-mit-disclaimer-rev'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         331,
                         'hpnd-uc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         332,
                         'hpnd-uc-export-us'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         333,
                         'htmltidy'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         334,
                         'ibm-pibs'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         335,
                         'icu'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         336,
                         'iec-code-components-eula'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         337,
                         'ijg'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         338,
                         'ijg-short'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         339,
                         'imagemagick'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         340,
                         'imatix'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         341,
                         'imlib2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         342,
                         'info-zip'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         343,
                         'inner-net-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         344,
                         'intel'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         345,
                         'intel-acpi'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         346,
                         'interbase-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         347,
                         'ipa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         348,
                         'ipl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         349,
                         'isc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         350,
                         'isc-veillard'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         351,
                         'jam'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         352,
                         'jasper-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         353,
                         'jpl-image'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         354,
                         'jpnic'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         355,
                         'json'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         356,
                         'kastrup'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         357,
                         'kazlib'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         358,
                         'knuth-ctan'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         359,
                         'lal-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         360,
                         'lal-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         361,
                         'latex2e'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         362,
                         'latex2e-translated-notice'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         363,
                         'leptonica'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         364,
                         'lgpl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         365,
                         'lgpl-2.0+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         366,
                         'lgpl-2.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         367,
                         'lgpl-2.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         368,
                         'lgpl-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         369,
                         'lgpl-2.1+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         370,
                         'lgpl-2.1-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         371,
                         'lgpl-2.1-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         372,
                         'lgpl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         373,
                         'lgpl-3.0+'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         374,
                         'lgpl-3.0-only'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         375,
                         'lgpl-3.0-or-later'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         376,
                         'lgpllr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         377,
                         'libpng'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         378,
                         'libpng-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         379,
                         'libselinux-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         380,
                         'libtiff'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         381,
                         'libutil-david-nugent'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         382,
                         'liliq-p-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         383,
                         'liliq-r-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         384,
                         'liliq-rplus-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         385,
                         'linux-man-pages-1-para'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         386,
                         'linux-man-pages-copyleft'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         387,
                         'linux-man-pages-copyleft-2-para'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         388,
                         'linux-man-pages-copyleft-var'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         389,
                         'linux-openib'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         390,
                         'loop'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         391,
                         'lpd-document'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         392,
                         'lpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         393,
                         'lpl-1.02'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         394,
                         'lppl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         395,
                         'lppl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         396,
                         'lppl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         397,
                         'lppl-1.3a'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         398,
                         'lppl-1.3c'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         399,
                         'lsof'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         400,
                         'lucida-bitmap-fonts'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         401,
                         'lzma-sdk-9.11-to-9.20'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         402,
                         'lzma-sdk-9.22'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         403,
                         'mackerras-3-clause'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         404,
                         'mackerras-3-clause-acknowledgment'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         405,
                         'magaz'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         406,
                         'mailprio'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         407,
                         'makeindex'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         408,
                         'martin-birgmeier'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         409,
                         'mcphee-slideshow'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         410,
                         'metamail'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         411,
                         'minpack'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         412,
                         'miros'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         413,
                         'mit'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         414,
                         'mit-0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         415,
                         'mit-advertising'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         416,
                         'mit-cmu'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         417,
                         'mit-enna'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         418,
                         'mit-feh'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         419,
                         'mit-festival'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         420,
                         'mit-khronos-old'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         421,
                         'mit-modern-variant'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         422,
                         'mit-open-group'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         423,
                         'mit-testregex'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         424,
                         'mit-wu'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         425,
                         'mitnfa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         426,
                         'mmixware'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         427,
                         'motosoto'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         428,
                         'mpeg-ssg'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         429,
                         'mpi-permissive'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         430,
                         'mpich2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         431,
                         'mpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         432,
                         'mpl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         433,
                         'mpl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         434,
                         'mpl-2.0-no-copyleft-exception'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         435,
                         'mplus'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         436,
                         'ms-lpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         437,
                         'ms-pl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         438,
                         'ms-rl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         439,
                         'mtll'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         440,
                         'mulanpsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         441,
                         'mulanpsl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         442,
                         'multics'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         443,
                         'mup'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         444,
                         'naist-2003'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         445,
                         'nasa-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         446,
                         'naumen'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         447,
                         'nbpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         448,
                         'ncbi-pd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         449,
                         'ncgl-uk-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         450,
                         'ncl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         451,
                         'ncsa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         452,
                         'net-snmp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         453,
                         'netcdf'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         454,
                         'newsletr'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         455,
                         'ngpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         456,
                         'nicta-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         457,
                         'nist-pd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         458,
                         'nist-pd-fallback'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         459,
                         'nist-software'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         460,
                         'nlod-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         461,
                         'nlod-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         462,
                         'nlpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         463,
                         'nokia'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         464,
                         'nosl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         465,
                         'noweb'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         466,
                         'npl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         467,
                         'npl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         468,
                         'nposl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         469,
                         'nrl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         470,
                         'ntp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         471,
                         'ntp-0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         472,
                         'nunit'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         473,
                         'o-uda-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         474,
                         'oar'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         475,
                         'occt-pl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         476,
                         'oclc-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         477,
                         'odbl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         478,
                         'odc-by-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         479,
                         'offis'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         480,
                         'ofl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         481,
                         'ofl-1.0-no-rfn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         482,
                         'ofl-1.0-rfn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         483,
                         'ofl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         484,
                         'ofl-1.1-no-rfn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         485,
                         'ofl-1.1-rfn'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         486,
                         'ogc-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         487,
                         'ogdl-taiwan-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         488,
                         'ogl-canada-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         489,
                         'ogl-uk-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         490,
                         'ogl-uk-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         491,
                         'ogl-uk-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         492,
                         'ogtsl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         493,
                         'oldap-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         494,
                         'oldap-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         495,
                         'oldap-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         496,
                         'oldap-1.4'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         497,
                         'oldap-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         498,
                         'oldap-2.0.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         499,
                         'oldap-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         500,
                         'oldap-2.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         501,
                         'oldap-2.2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         502,
                         'oldap-2.2.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         503,
                         'oldap-2.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         504,
                         'oldap-2.4'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         505,
                         'oldap-2.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         506,
                         'oldap-2.6'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         507,
                         'oldap-2.7'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         508,
                         'oldap-2.8'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         509,
                         'olfl-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         510,
                         'oml'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         511,
                         'openpbs-2.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         512,
                         'openssl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         513,
                         'openssl-standalone'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         514,
                         'openvision'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         515,
                         'opl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         516,
                         'opl-uk-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         517,
                         'opubl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         518,
                         'oset-pl-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         519,
                         'osl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         520,
                         'osl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         521,
                         'osl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         522,
                         'osl-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         523,
                         'osl-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         524,
                         'padl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         525,
                         'parity-6.0.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         526,
                         'parity-7.0.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         527,
                         'pddl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         528,
                         'php-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         529,
                         'php-3.01'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         530,
                         'pixar'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         531,
                         'pkgconf'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         532,
                         'plexus'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         533,
                         'pnmstitch'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         534,
                         'polyform-noncommercial-1.0.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         535,
                         'polyform-small-business-1.0.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         536,
                         'postgresql'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         537,
                         'ppl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         538,
                         'psf-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         539,
                         'psfrag'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         540,
                         'psutils'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         541,
                         'python-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         542,
                         'python-2.0.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         543,
                         'python-ldap'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         544,
                         'qhull'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         545,
                         'qpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         546,
                         'qpl-1.0-inria-2004'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         547,
                         'radvd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         548,
                         'rdisc'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         549,
                         'rhecos-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         550,
                         'rpl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         551,
                         'rpl-1.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         552,
                         'rpsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         553,
                         'rsa-md'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         554,
                         'rscpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         555,
                         'ruby'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         556,
                         'ruby-pty'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         557,
                         'sax-pd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         558,
                         'sax-pd-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         559,
                         'saxpath'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         560,
                         'scea'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         561,
                         'schemereport'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         562,
                         'sendmail'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         563,
                         'sendmail-8.23'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         564,
                         'sgi-b-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         565,
                         'sgi-b-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         566,
                         'sgi-b-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         567,
                         'sgi-opengl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         568,
                         'sgp4'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         569,
                         'shl-0.5'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         570,
                         'shl-0.51'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         571,
                         'simpl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         572,
                         'sissl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         573,
                         'sissl-1.2'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         574,
                         'sl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         575,
                         'sleepycat'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         576,
                         'smlnj'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         577,
                         'smppl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         578,
                         'snia'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         579,
                         'snprintf'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         580,
                         'softsurfer'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         581,
                         'soundex'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         582,
                         'spencer-86'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         583,
                         'spencer-94'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         584,
                         'spencer-99'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         585,
                         'spl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         586,
                         'ssh-keyscan'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         587,
                         'ssh-openssh'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         588,
                         'ssh-short'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         589,
                         'ssleay-standalone'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         590,
                         'sspl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         591,
                         'standardml-nj'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         592,
                         'sugarcrm-1.1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         593,
                         'sun-ppp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         594,
                         'sun-ppp-2000'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         595,
                         'sunpro'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         596,
                         'swl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         597,
                         'swrule'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         598,
                         'symlinks'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         599,
                         'tapr-ohl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         600,
                         'tcl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         601,
                         'tcp-wrappers'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         602,
                         'termreadkey'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         603,
                         'tgppl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         604,
                         'threeparttable'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         605,
                         'tmate'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         606,
                         'torque-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         607,
                         'tosl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         608,
                         'tpdl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         609,
                         'tpl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         610,
                         'ttwl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         611,
                         'ttyp0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         612,
                         'tu-berlin-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         613,
                         'tu-berlin-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         614,
                         'ucar'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         615,
                         'ucl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         616,
                         'ulem'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         617,
                         'umich-merit'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         618,
                         'unicode-3.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         619,
                         'unicode-dfs-2015'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         620,
                         'unicode-dfs-2016'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         621,
                         'unicode-tou'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         622,
                         'unixcrypt'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         623,
                         'unlicense'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         624,
                         'upl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         625,
                         'urt-rle'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         626,
                         'vim'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         627,
                         'vostrom'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         628,
                         'vsl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         629,
                         'w3c'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         630,
                         'w3c-19980720'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         631,
                         'w3c-20150513'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         632,
                         'w3m'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         633,
                         'watcom-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         634,
                         'widget-workshop'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         635,
                         'wsuipa'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         636,
                         'wtfpl'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         637,
                         'wxwindows'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         638,
                         'x11'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         639,
                         'x11-distribute-modifications-variant'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         640,
                         'x11-swapped'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         641,
                         'xdebug-1.03'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         642,
                         'xerox'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         643,
                         'xfig'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         644,
                         'xfree86-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         645,
                         'xinetd'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         646,
                         'xkeyboard-config-zinoviev'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         647,
                         'xlock'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         648,
                         'xnet'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         649,
                         'xpp'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         650,
                         'xskat'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         651,
                         'xzoom'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         652,
                         'ypl-1.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         653,
                         'ypl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         654,
                         'zed'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         655,
                         'zeeff'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         656,
                         'zend-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         657,
                         'zimbra-1.3'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         658,
                         'zimbra-1.4'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         659,
                         'zlib'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         660,
                         'zlib-acknowledgement'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         661,
                         'zpl-1.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         662,
                         'zpl-2.0'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         663,
                         'zpl-2.1'
                     );

INSERT INTO Licenses (
                         Id,
                         Name
                     )
                     VALUES (
                         664,
                         'proprietary'
                     );


-- Table: PkgRequires
DROP TABLE IF EXISTS PkgRequires;

CREATE TABLE IF NOT EXISTS PkgRequires (
    Id             INTEGER PRIMARY KEY AUTOINCREMENT
                           UNIQUE
                           NOT NULL,
    Name           STRING  NOT NULL,
    DependencyType INTEGER NOT NULL
                           REFERENCES DependencyTypes (Id),
    Dependency     STRING  NOT NULL
);


-- Table: PkgTypes
DROP TABLE IF EXISTS PkgTypes;

CREATE TABLE IF NOT EXISTS PkgTypes (
    Id   INTEGER PRIMARY KEY AUTOINCREMENT
                 UNIQUE
                 NOT NULL,
    Type STRING  UNIQUE
                 NOT NULL
);

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         1,
                         'binary'
                     );

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         2,
                         'srcbuild'
                     );

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         3,
                         'source'
                     );

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         4,
                         'bundle'
                     );

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         5,
                         'metapkg'
                     );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
