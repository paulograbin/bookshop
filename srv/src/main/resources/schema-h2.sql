
DROP VIEW IF EXISTS localized_CatalogService_Currencies;
DROP VIEW IF EXISTS localized_CatalogService_Genres;
DROP VIEW IF EXISTS localized_CatalogService_Books;
DROP VIEW IF EXISTS localized_AdminService_Currencies;
DROP VIEW IF EXISTS localized_AdminService_GenreHierarchy;
DROP VIEW IF EXISTS localized_AdminService_Books;
DROP VIEW IF EXISTS AdminService_DraftAdministrativeData;
DROP VIEW IF EXISTS localized_sap_common_Currencies;
DROP VIEW IF EXISTS localized_sap_capire_bookshop_Genres;
DROP VIEW IF EXISTS localized_sap_capire_bookshop_Books;
DROP VIEW IF EXISTS CatalogService_Books_texts;
DROP VIEW IF EXISTS CatalogService_Currencies_texts;
DROP VIEW IF EXISTS CatalogService_Currencies;
DROP VIEW IF EXISTS CatalogService_Genres_texts;
DROP VIEW IF EXISTS CatalogService_Genres;
DROP VIEW IF EXISTS CatalogService_Books;
DROP VIEW IF EXISTS AdminService_OrderItems;
DROP VIEW IF EXISTS AdminService_Orders;
DROP VIEW IF EXISTS AdminService_Books_texts;
DROP VIEW IF EXISTS AdminService_Currencies_texts;
DROP VIEW IF EXISTS AdminService_Currencies;
DROP VIEW IF EXISTS AdminService_GenreHierarchy_texts;
DROP VIEW IF EXISTS AdminService_GenreHierarchy;
DROP VIEW IF EXISTS AdminService_Authors;
DROP VIEW IF EXISTS AdminService_Books;
DROP TABLE IF EXISTS AdminService_OrderItems_drafts;
DROP TABLE IF EXISTS AdminService_Orders_drafts;
DROP TABLE IF EXISTS AdminService_GenreHierarchy_drafts;
DROP TABLE IF EXISTS AdminService_Books_drafts;
DROP TABLE IF EXISTS DRAFT_DraftAdministrativeData;
DROP TABLE IF EXISTS cds_outbox_Messages;
DROP TABLE IF EXISTS sap_capire_bookshop_OrderItems;
DROP TABLE IF EXISTS sap_capire_bookshop_Orders;
DROP TABLE IF EXISTS sap_capire_bookshop_Books_texts;
DROP TABLE IF EXISTS sap_common_Currencies_texts;
DROP TABLE IF EXISTS sap_common_Currencies;
DROP TABLE IF EXISTS sap_capire_bookshop_Genres_texts;
DROP TABLE IF EXISTS sap_capire_bookshop_Genres;
DROP TABLE IF EXISTS sap_capire_bookshop_Authors;
DROP TABLE IF EXISTS sap_capire_bookshop_Books;

CREATE TABLE sap_capire_bookshop_Books (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  ID INTEGER NOT NULL,
  title NVARCHAR(111),
  descr NVARCHAR(1111),
  author_ID INTEGER,
  genre_ID INTEGER,
  stock INTEGER,
  price DECIMAL(9, 2),
  currency_code NVARCHAR(3),
  PRIMARY KEY(ID)
);

CREATE TABLE sap_capire_bookshop_Authors (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  ID INTEGER NOT NULL,
  name NVARCHAR(111),
  PRIMARY KEY(ID)
);

CREATE TABLE sap_capire_bookshop_Genres (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  ID INTEGER NOT NULL,
  parent_ID INTEGER,
  PRIMARY KEY(ID)
);

CREATE TABLE sap_capire_bookshop_Genres_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  ID INTEGER NOT NULL,
  PRIMARY KEY(locale, ID)
);

CREATE TABLE sap_common_Currencies (
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  symbol NVARCHAR(5),
  minorUnit SMALLINT,
  PRIMARY KEY(code)
);

CREATE TABLE sap_common_Currencies_texts (
  locale NVARCHAR(14) NOT NULL,
  name NVARCHAR(255),
  descr NVARCHAR(1000),
  code NVARCHAR(3) NOT NULL,
  PRIMARY KEY(locale, code)
);

CREATE TABLE sap_capire_bookshop_Books_texts (
  locale NVARCHAR(14) NOT NULL,
  ID INTEGER NOT NULL,
  title NVARCHAR(111),
  descr NVARCHAR(1111),
  PRIMARY KEY(locale, ID)
);

CREATE TABLE sap_capire_bookshop_Orders (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  OrderNo NVARCHAR(255),
  buyer NVARCHAR(255),
  total DECIMAL(9, 2),
  currency_code NVARCHAR(3),
  PRIMARY KEY(ID)
);

CREATE TABLE sap_capire_bookshop_OrderItems (
  ID NVARCHAR(36) NOT NULL,
  parent_ID NVARCHAR(36),
  book_ID INTEGER,
  quantity INTEGER,
  amount DECIMAL(9, 2),
  PRIMARY KEY(ID)
);

CREATE TABLE cds_outbox_Messages (
  ID NVARCHAR(36) NOT NULL,
  timestamp TIMESTAMP(7),
  target NVARCHAR(255),
  msg NCLOB,
  attempts INTEGER DEFAULT 0,
  "PARTITION" INTEGER DEFAULT 0,
  lastError NCLOB,
  lastAttemptTimestamp TIMESTAMP(7),
  status NVARCHAR(23),
  PRIMARY KEY(ID)
);

CREATE TABLE DRAFT_DraftAdministrativeData (
  DraftUUID NVARCHAR(36) NOT NULL,
  CreationDateTime TIMESTAMP(7),
  CreatedByUser NVARCHAR(256),
  CreatedByUserDescription NVARCHAR(256),
  DraftIsCreatedByMe BOOLEAN,
  LastChangeDateTime TIMESTAMP(7),
  LastChangedByUser NVARCHAR(256),
  LastChangedByUserDescription NVARCHAR(256),
  InProcessByUser NVARCHAR(256),
  InProcessByUserDescription NVARCHAR(256),
  DraftIsProcessedByMe BOOLEAN,
  DraftMessages NCLOB,
  PRIMARY KEY(DraftUUID)
);

CREATE TABLE AdminService_Books_drafts (
  createdAt TIMESTAMP(7) NULL,
  createdBy NVARCHAR(255) NULL,
  modifiedAt TIMESTAMP(7) NULL,
  modifiedBy NVARCHAR(255) NULL,
  ID INTEGER NOT NULL,
  title NVARCHAR(111) NULL,
  descr NVARCHAR(1111) NULL,
  author_ID INTEGER NULL,
  genre_ID INTEGER NULL,
  stock INTEGER NULL,
  price DECIMAL(9, 2) NULL,
  currency_code NVARCHAR(3) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE TABLE AdminService_GenreHierarchy_drafts (
  name NVARCHAR(255) NULL,
  descr NVARCHAR(1000) NULL,
  ID INTEGER NOT NULL,
  parent_ID INTEGER NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE TABLE AdminService_Orders_drafts (
  ID NVARCHAR(36) NOT NULL,
  createdAt TIMESTAMP(7) NULL,
  createdBy NVARCHAR(255) NULL,
  modifiedAt TIMESTAMP(7) NULL,
  modifiedBy NVARCHAR(255) NULL,
  OrderNo NVARCHAR(255) NULL,
  buyer NVARCHAR(255) NULL,
  total DECIMAL(9, 2) NULL,
  currency_code NVARCHAR(3) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE TABLE AdminService_OrderItems_drafts (
  ID NVARCHAR(36) NOT NULL,
  parent_ID NVARCHAR(36) NULL,
  book_ID INTEGER NULL,
  quantity INTEGER NULL,
  amount DECIMAL(9, 2) NULL,
  IsActiveEntity BOOLEAN,
  HasActiveEntity BOOLEAN,
  HasDraftEntity BOOLEAN,
  DraftAdministrativeData_DraftUUID NVARCHAR(36) NOT NULL,
  PRIMARY KEY(ID)
);

CREATE VIEW AdminService_Books AS SELECT
  Books_0.createdAt,
  Books_0.createdBy,
  Books_0.modifiedAt,
  Books_0.modifiedBy,
  Books_0.ID,
  Books_0.title,
  Books_0.descr,
  Books_0.author_ID,
  Books_0.genre_ID,
  Books_0.stock,
  Books_0.price,
  Books_0.currency_code
FROM sap_capire_bookshop_Books AS Books_0;

CREATE VIEW AdminService_Authors AS SELECT
  Authors_0.createdAt,
  Authors_0.createdBy,
  Authors_0.modifiedAt,
  Authors_0.modifiedBy,
  Authors_0.ID,
  Authors_0.name
FROM sap_capire_bookshop_Authors AS Authors_0;

CREATE VIEW AdminService_GenreHierarchy AS SELECT
  Genres_0.name,
  Genres_0.descr,
  Genres_0.ID,
  Genres_0.parent_ID
FROM sap_capire_bookshop_Genres AS Genres_0;

CREATE VIEW AdminService_GenreHierarchy_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.ID
FROM sap_capire_bookshop_Genres_texts AS texts_0;

CREATE VIEW AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM sap_common_Currencies AS Currencies_0;

CREATE VIEW AdminService_Currencies_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_common_Currencies_texts AS texts_0;

CREATE VIEW AdminService_Books_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.title,
  texts_0.descr
FROM sap_capire_bookshop_Books_texts AS texts_0;

CREATE VIEW AdminService_Orders AS SELECT
  Orders_0.ID,
  Orders_0.createdAt,
  Orders_0.createdBy,
  Orders_0.modifiedAt,
  Orders_0.modifiedBy,
  Orders_0.OrderNo,
  Orders_0.buyer,
  Orders_0.total,
  Orders_0.currency_code
FROM sap_capire_bookshop_Orders AS Orders_0;

CREATE VIEW AdminService_OrderItems AS SELECT
  OrderItems_0.ID,
  OrderItems_0.parent_ID,
  OrderItems_0.book_ID,
  OrderItems_0.quantity,
  OrderItems_0.amount
FROM sap_capire_bookshop_OrderItems AS OrderItems_0;

CREATE VIEW CatalogService_Books AS SELECT
  Books_0.createdAt,
  Books_0.modifiedAt,
  Books_0.ID,
  Books_0.title,
  Books_0.descr,
  author_1.name AS author,
  Books_0.genre_ID,
  Books_0.stock,
  Books_0.price,
  Books_0.currency_code
FROM (sap_capire_bookshop_Books AS Books_0 LEFT JOIN sap_capire_bookshop_Authors AS author_1 ON Books_0.author_ID = author_1.ID);

CREATE VIEW CatalogService_Genres AS SELECT
  Genres_0.name,
  Genres_0.descr,
  Genres_0.ID,
  Genres_0.parent_ID
FROM sap_capire_bookshop_Genres AS Genres_0;

CREATE VIEW CatalogService_Genres_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.ID
FROM sap_capire_bookshop_Genres_texts AS texts_0;

CREATE VIEW CatalogService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM sap_common_Currencies AS Currencies_0;

CREATE VIEW CatalogService_Currencies_texts AS SELECT
  texts_0.locale,
  texts_0.name,
  texts_0.descr,
  texts_0.code
FROM sap_common_Currencies_texts AS texts_0;

CREATE VIEW CatalogService_Books_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.title,
  texts_0.descr
FROM sap_capire_bookshop_Books_texts AS texts_0;

CREATE VIEW localized_sap_capire_bookshop_Books AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.ID,
  coalesce(localized_1.title, L_0.title) AS title,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.author_ID,
  L_0.genre_ID,
  L_0.stock,
  L_0.price,
  L_0.currency_code
FROM (sap_capire_bookshop_Books AS L_0 LEFT JOIN sap_capire_bookshop_Books_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = @locale);

CREATE VIEW localized_sap_capire_bookshop_Genres AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.ID,
  L_0.parent_ID
FROM (sap_capire_bookshop_Genres AS L_0 LEFT JOIN sap_capire_bookshop_Genres_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = @locale);

CREATE VIEW localized_sap_common_Currencies AS SELECT
  coalesce(localized_1.name, L_0.name) AS name,
  coalesce(localized_1.descr, L_0.descr) AS descr,
  L_0.code,
  L_0.symbol,
  L_0.minorUnit
FROM (sap_common_Currencies AS L_0 LEFT JOIN sap_common_Currencies_texts AS localized_1 ON localized_1.code = L_0.code AND localized_1.locale = @locale);

CREATE VIEW AdminService_DraftAdministrativeData AS SELECT
  DraftAdministrativeData.DraftUUID,
  DraftAdministrativeData.CreationDateTime,
  DraftAdministrativeData.CreatedByUser,
  DraftAdministrativeData.CreatedByUserDescription,
  DraftAdministrativeData.DraftIsCreatedByMe,
  DraftAdministrativeData.LastChangeDateTime,
  DraftAdministrativeData.LastChangedByUser,
  DraftAdministrativeData.LastChangedByUserDescription,
  DraftAdministrativeData.InProcessByUser,
  DraftAdministrativeData.InProcessByUserDescription,
  DraftAdministrativeData.DraftIsProcessedByMe,
  DraftAdministrativeData.DraftMessages
FROM DRAFT_DraftAdministrativeData AS DraftAdministrativeData;

CREATE VIEW localized_AdminService_Books AS SELECT
  Books_0.createdAt,
  Books_0.createdBy,
  Books_0.modifiedAt,
  Books_0.modifiedBy,
  Books_0.ID,
  Books_0.title,
  Books_0.descr,
  Books_0.author_ID,
  Books_0.genre_ID,
  Books_0.stock,
  Books_0.price,
  Books_0.currency_code
FROM localized_sap_capire_bookshop_Books AS Books_0;

CREATE VIEW localized_AdminService_GenreHierarchy AS SELECT
  Genres_0.name,
  Genres_0.descr,
  Genres_0.ID,
  Genres_0.parent_ID
FROM localized_sap_capire_bookshop_Genres AS Genres_0;

CREATE VIEW localized_AdminService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM localized_sap_common_Currencies AS Currencies_0;

CREATE VIEW localized_CatalogService_Books AS SELECT
  Books_0.createdAt,
  Books_0.modifiedAt,
  Books_0.ID,
  Books_0.title,
  Books_0.descr,
  author_1.name AS author,
  Books_0.genre_ID,
  Books_0.stock,
  Books_0.price,
  Books_0.currency_code
FROM (localized_sap_capire_bookshop_Books AS Books_0 LEFT JOIN sap_capire_bookshop_Authors AS author_1 ON Books_0.author_ID = author_1.ID);

CREATE VIEW localized_CatalogService_Genres AS SELECT
  Genres_0.name,
  Genres_0.descr,
  Genres_0.ID,
  Genres_0.parent_ID
FROM localized_sap_capire_bookshop_Genres AS Genres_0;

CREATE VIEW localized_CatalogService_Currencies AS SELECT
  Currencies_0.name,
  Currencies_0.descr,
  Currencies_0.code,
  Currencies_0.symbol,
  Currencies_0.minorUnit
FROM localized_sap_common_Currencies AS Currencies_0;
