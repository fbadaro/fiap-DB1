-- Procedure que inseri alguns valores nas tabelas para testes
CREATE OR REPLACE PROCEDURE PR_DB1_LOAD_DATA
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