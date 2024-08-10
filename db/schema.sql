--
-- File generated with SQLiteStudio v3.4.4 on Sat Aug 10 12:04:21 2024
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
                         'pkgarchive'
                     );

INSERT INTO PkgTypes (
                         Id,
                         Type
                     )
                     VALUES (
                         2,
                         'pkgsrc'
                     );


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
