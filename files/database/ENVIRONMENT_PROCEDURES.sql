-- Procedure que criar as tabelas do ambiente
CREATE OR REPLACE PROCEDURE PR_DB1_CREATE_TABLES
AUTHID CURRENT_USER
IS
    fabricante VARCHAR(2000) := '
        CREATE TABLE TDB1_FABRICANTE (
            FE_ID                   INTEGER NOT NULL,
            FE_NOME_FANTASIA        VARCHAR2(100) NOT NULL,
            FE_RAZAO_SOCIAL         VARCHAR2(100) NOT NULL,
            FE_INSCRICAO            VARCHAR(12) NOT NULL,
            FE_DATA_ABERTURA        DATE NOT NULL,
            FE_SITE                 VARCHAR(100) NULL,
            FE_CNPJ                 VARCHAR2(14) NOT NULL,
            FE_ENDERECO             VARCHAR2(150) NOT NULL,
            FE_CEP                  VARCHAR2(8) NOT NULL,
            FE_BAIRRO               VARCHAR2(50) NOT NULL,
            FE_COMPLEMENTO          VARCHAR2(30) NULL,
            FE_TELEFONE             VARCHAR2(14) NOT NULL,
            FE_EMAIL                VARCHAR2(50) NOT NULL,
            CONSTRAINT TDB1_FABRICANTE_PK PRIMARY KEY ( FE_ID )
        )';

    produto VARCHAR(2000) := '
        CREATE TABLE TDB2_PRODUTO (
            PO_ID                   INTEGER NOT NULL,
            PO_NOME                 VARCHAR2(60) NOT NULL,
            PO_DESCRICAO            VARCHAR2(400) NOT NULL,
            PO_CODIGO               VARCHAR2(16) NOT NULL,
            PO_NUMERO_SERIE         VARCHAR2(80) NOT NULL,
            PO_PESO_LIQUIDO         NUMBER(18,10) NOT NULL,
            PO_PESO_EMBALAGEM       NUMBER(18,10) NOT NULL,
            PO_VOLUME               NUMBER(25,10) NOT NULL,
            PO_DIMENSOES            NUMBER(18) NOT NULL,
            PO_ATIVO                CHAR(1) NOT NULL,
            PO_ORIGEM               CHAR(1) NOT NULL,
            PO_TIPO                 CHAR(1) NOT NULL,
            PO_ESTOQUE              INTEGER NOT NULL,
            PO_DATA_CRIACAO         TIMESTAMP NOT NULL,
            PO_DATA_ATUALIZACAO     TIMESTAMP NULL,
            PO_DATA_DESATIVACAO     TIMESTAMP NULL,
            PO_VALOR                NUMBER(6,2) NOT NULL,
            TDB1_FABRICANTE_FE_ID   INTEGER NOT NULL,
            CONSTRAINT TDB2_PRODUTO_PK PRIMARY KEY ( PO_ID ),
            CONSTRAINT TDB2_PRODUTO_TDB1_FABRICANTE FOREIGN KEY 
                ( TDB1_FABRICANTE_FE_ID ) REFERENCES TDB1_FABRICANTE ( FE_ID )
        )';

    produto_log VARCHAR(2000) := '
        CREATE TABLE TDB3_LOG(
            LG_ID_ENTIDADE          INTEGER NOT NULL,
            LG_NOME_ENTIDADE        VARCHAR(100) NOT NULL,
            LG_DATA_MODIFICACAO     TIMESTAMP NOT NULL,
            LG_USUARIO              VARCHAR(100) NOT NULL,
            LG_ANTES_ALTERACAO      VARCHAR(4000),
            LG_DEPOIS_ALTERACAO     VARCHAR(4000)
        )';

    produto_notificacao VARCHAR(2000) := '
        CREATE TABLE TDB4_NOTIF_PRODUTO(
            NT_ID                   INTEGER NOT NULL,
            NT_QTDE_ESTOQUE         INTEGER NOT NULL,
            NT_DATA                 TIMESTAMP,
            NT_MENSAGEM             VARCHAR2(4000) NOT NULL,            
            CONSTRAINT TDB4_NOTIFICACAO_PRODUTO_PK PRIMARY KEY ( NT_ID )
    )';

BEGIN
    runcommand(fabricante);
    runcommand(produto);
    runcommand(produto_log);
    runcommand(produto_notificacao);
END;

-- Procedure que cria as sequences das tabelas e atualizar sequence nas tabelas
CREATE OR REPLACE PROCEDURE PR_DB1_CREATE_SEQUENCES
AUTHID CURRENT_USER
IS
    fabricante VARCHAR(1000) := '
        CREATE SEQUENCE TDB1_FABRICANTE_SEQ
            START WITH 1
            INCREMENT BY 1
            CACHE 20';

    produto VARCHAR(1000) := '
        CREATE SEQUENCE TDB2_PRODUTO_SEQ
            START WITH 1
            INCREMENT BY 1
            CACHE 20';

    produto_notificacao VARCHAR(1000) := '
        CREATE SEQUENCE TDB4_NOTIF_PRODUTO_SEQ
            START WITH 1
            INCREMENT BY 1
            CACHE 20';

    update_fabricante VARCHAR(1000) := '
        UPDATE TDB1_FABRICANTE SET FE_ID = TDB1_FABRICANTE_SEQ.NEXTVAL';

    update_produto VARCHAR(1000) := '
        UPDATE TDB2_PRODUTO SET PO_ID = TDB2_PRODUTO_SEQ.NEXTVAL';

    update_produto_notificacao VARCHAR(1000) := '
        UPDATE TDB4_NOTIF_PRODUTO SET NT_ID = TDB4_NOTIF_PRODUTO_SEQ.NEXTVAL';
BEGIN
    runcommand(fabricante);
    runcommand(produto);
    runcommand(produto_notificacao);
    runcommand(update_fabricante);
    runcommand(update_produto);
    runcommand(update_produto_notificacao);
END;

-- Procedure que deleta todas tabelas e sequences
CREATE OR REPLACE PROCEDURE PR_DB1_DROP_ENVIRONMENT
AUTHID CURRENT_USER
IS
BEGIN
    runcommand('DROP TABLE TDB2_PRODUTO');
    runcommand('DROP TABLE TDB1_FABRICANTE');
    runcommand('DROP TABLE TDB3_LOG');
    runcommand('DROP TABLE TDB4_NOTIF_PRODUTO');
    runcommand('DROP SEQUENCE TDB1_FABRICANTE_SEQ');
    runcommand('DROP SEQUENCE TDB2_PRODUTO_SEQ');
END;

-- Procedure que inicia o ambiente com tabela, sequences e dados
CREATE OR REPLACE PROCEDURE PR_DB1_INIT_ENVIRONMENT
AUTHID CURRENT_USER
IS
BEGIN
    PR_DB1_CREATE_TABLES;
    PR_DB1_CREATE_SEQUENCES;
    PR_DB1_LOAD_DATA;
END;

-- Procedure que reseta o ambiente e ja inicia outro com todas tabelas, sequences e dados pra teste
CREATE OR REPLACE PROCEDURE PR_DB1_RESET_ENVIRONMENT
AUTHID CURRENT_USER
IS
BEGIN
    PR_DB1_DROP_ENVIRONMENT;
    PR_DB1_INIT_ENVIRONMENT;
END;

-- EXEC PR_DB1_RESET_ENVIRONMENT;
-- EXEC PR_DB1_INIT_ENVIRONMENT;
