CREATE OR REPLACE PROCEDURE runcommand (command IN VARCHAR2)
AUTHID CURRENT_USER
IS
BEGIN
    EXECUTE IMMEDIATE command;
END;

-- Procedure que criar as tabelas do ambiente
CREATE OR REPLACE PROCEDURE create_tables
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
            CONSTRAINT TDB2_PRODUTO_TDB1_FABRICANTE_FK FOREIGN KEY 
                ( TDB1_FABRICANTE_FE_ID ) REFERENCES TDB1_FABRICANTE ( FE_ID )
        )';
BEGIN
    runcommand(fabricante);
    runcommand(produto);
END;

-- Procedure que cria as sequences das tabelas e atualizar sequence nas tabelas
CREATE OR REPLACE PROCEDURE create_sequences
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

    update_fabricante VARCHAR(1000) := '
        UPDATE TDB1_FABRICANTE SET FE_ID = TDB1_FABRICANTE_SEQ.NEXTVAL';

    update_produte VARCHAR(1000) := '
        UPDATE TDB2_PRODUTO SET PO_ID = TDB2_PRODUTO_SEQ.NEXTVAL';
BEGIN
    runcommand(fabricante);
    runcommand(produto);
    runcommand(update_fabricante);
    runcommand(update_produte);
END;

-- Procedure que deleta todas tabelas e sequences
CREATE OR REPLACE PROCEDURE drop_environment
AUTHID CURRENT_USER
IS
BEGIN
    runcommand('DROP TABLE TDB2_PRODUTO');
    runcommand('DROP TABLE TDB1_FABRICANTE');
    runcommand('DROP SEQUENCE TDB1_FABRICANTE_SEQ');
    runcommand('DROP SEQUENCE TDB2_PRODUTO_SEQ');
END;

-- Procedure que inseri alguns valores nas tabelas para testes
CREATE OR REPLACE PROCEDURE load_data
AUTHID CURRENT_USER
IS
    -- Fabricantes
    fabricante1 VARCHAR(1000) := q'[INSERT INTO TDB1_FABRICANTE 
        VALUES (TDB1_FABRICANTE_SEQ.NEXTVAL, 'Oscorp Industries', 'Norman Osborn Industries Ltda',
                '948396774525', TO_DATE( '03 Jun 1995', 'DD MON YYYY' ), 'www.oscorp.com',
                '59445500000180', 'Rua José Medina, 933', '17516715', 'Parque das Esmeraldas',
                NULL, '1428143205', 'contato@oscorp.com')]';

    fabricante2 VARCHAR(1000) := q'[INSERT INTO TDB1_FABRICANTE 
        VALUES (TDB1_FABRICANTE_SEQ.NEXTVAL, 'Lex Company', 'Lex Luthor Companies Ltda',
                '801850404096', TO_DATE( '07 Jul 1997', 'DD MON YYYY' ), 'www.lexcompany.com',
                '17123715000134', 'Rua Geranios, 506', '12420718', 'Loteamento Residencial Reserva Bonsucesso',
                NULL, '1238902168', 'contato@lex.com')]';

    fabricante3 VARCHAR(1000) := q'[INSERT INTO TDB1_FABRICANTE  
        VALUES (TDB1_FABRICANTE_SEQ.NEXTVAL, 'Acme Corp', 'Acme Corporation',
                '680123730431', TO_DATE( '07 Jul 1960', 'DD MON YYYY' ), 'www.acmebomb.com',
                '92992563000121', 'Rua Camélia, 103', '07813055', 'Villa Verde',
                'Conj 2', '1139356137','contato@acme.com')]';

    fabricante4 VARCHAR(1000) := q'[INSERT INTO TDB1_FABRICANTE 
        VALUES (TDB1_FABRICANTE_SEQ.NEXTVAL, 'Wayne Enterprises', 'Wayne Industrias',
                '903197407665', TO_DATE( '23 Jan 1967', 'DD MON YYYY' ), 'www.wayne.com',
                '20632508000110', 'Rua Líbia, 4138', '08695135', 'Jardim São José',
                NULL, '1138926348', 'contato@wayne.com')]';

    fabricante5 VARCHAR(1000) := q'[INSERT INTO TDB1_FABRICANTE 
        VALUES (TDB1_FABRICANTE_SEQ.NEXTVAL, 'Umbrella', 'Umbrella Corporations',
                '505737743991', TO_DATE( '15 Mar 1990', 'DD MON YYYY' ), 'www.umbrella.com',
                '08680054000157', 'Praça Duque de Caxias, 839', '13566503', 'Cidade Jardim',
                NULL, '1629359438', 'contato@umbrella.com')]';

    -- Fabricantes => Produtos
    fabricante1_produto1 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Oscorp Industries I', 'Descricao do produto I', '61360180044',
            '07467360000147', 10.0, 12.0, 40.0, 20.0, 'S', '1', '1', 15, LOCALTIMESTAMP, NULL, NULL, 14.90, 1)]';

    fabricante1_produto2 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Oscorp Industries II', 'Descricao do produto II', '41260181145',
            '87467360123148', 14.0, 16.0, 52.0, 24.0, 'S', '1', '1', 10, LOCALTIMESTAMP, NULL, NULL, 350.90, 1)]';

    fabricante2_produto1 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Lex Company I', 'Descricao do produto I', '78464510524',
            '81467360450147', 12.0, 14.0, 30.0, 15.0, 'S', '1', '1', 150, LOCALTIMESTAMP, NULL, NULL, 9.90, 2)]';

    fabricante2_produto2 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Lex Company II', 'Descricao do produto II', '91605461075',
            '13623574000168', 34.0, 38.0, 80.0, 60.0, 'S', '1', '1', 9, LOCALTIMESTAMP, NULL, NULL, 299.90, 2)]';

    fabricante3_produto1 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Acme Corp I', 'Descricao do produto I', '81342402081',
            '83379915000187', 180.0, 190.0, 120.0, 80.0, 'S', '1', '1', 150, LOCALTIMESTAMP, NULL, NULL, 299.90, 3)]';

    fabricante3_produto2 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Acme Corp II', 'Descricao do produto II', '92608854001',
            '05978713000148', 10.0, 12.0, 40.0, 20.0, 'S', '1', '1', 400, LOCALTIMESTAMP, NULL, NULL, 199.90, 3)]';

    fabricante4_produto1 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Wayne Enterprises I', 'Descricao do produto I', '59830057070',
            '31556978000168', 25.0, 30.0, 80.0, 40.0, 'S', '1', '1', 200, LOCALTIMESTAMP, NULL, NULL, 199.90, 4)]';

    fabricante4_produto2 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Wayne Enterprises II', 'Descricao do produto II', '01258398044',
            '59188188000196', 55.0, 65.0, 95.0, 65.0, 'S', '1', '1', 10, LOCALTIMESTAMP, NULL, NULL, 199.90, 4)]';

    fabricante5_produto1 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Umbrella I', 'Descricao do produto I', '23757873076',
            '56342500000166', 15.0, 18.0, 35.0, 25.0, 'S', '1', '1', 100, LOCALTIMESTAMP, NULL, NULL, 59.90, 5)]';

    fabricante5_produto2 VARCHAR(1000) := q'[INSERT INTO TDB2_PRODUTO 
        VALUES(TDB2_PRODUTO_SEQ.NEXTVAL, 'Produto Umbrella II', 'Descricao do produto II', '48741416090',
            '32705564000116', 45.0, 55.0, 45.0, 35.0, 'S', '1', '1', 90, LOCALTIMESTAMP, NULL, NULL, 39.90, 5)]';
BEGIN
    -- Fabricantes
    runcommand(fabricante1);
    runcommand(fabricante2);
    runcommand(fabricante3);
    runcommand(fabricante4);
    runcommand(fabricante5);

    -- Produtos
    runcommand(fabricante1_produto1);
    runcommand(fabricante1_produto2);

    runcommand(fabricante2_produto1);
    runcommand(fabricante2_produto2);

    runcommand(fabricante3_produto1);
    runcommand(fabricante3_produto2);

    runcommand(fabricante4_produto1);
    runcommand(fabricante4_produto2);

    runcommand(fabricante5_produto1);
    runcommand(fabricante5_produto2);
        
    COMMIT;
END;

-- Procedure que inicia o ambiente com tabela, sequences e dados
CREATE OR REPLACE PROCEDURE init_environment
AUTHID CURRENT_USER
IS
BEGIN
    create_tables;
    create_sequences;
    load_data;
END;

-- Procedure que reseta o ambiente e ja inicia outro com todas tabelas, sequences e dados pra teste
CREATE OR REPLACE PROCEDURE reset_environment
AUTHID CURRENT_USER
IS
BEGIN
    drop_environment;
    iniciar_ambiente;
END;


-- EXEC reset_environment;
-- EXEC init_environment;