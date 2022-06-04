-- Trigger que salva um log quando a quantidade de um produto cai abaixo de 10
CREATE OR REPLACE TRIGGER TR_DB1_NOTIFY_LOW_PRODUCT
AFTER UPDATE OF PO_ESTOQUE ON TDB2_PRODUTO
FOR EACH ROW
    WHEN (NEW.PO_ESTOQUE <= 10)
DECLARE
    v_log TDB3_LOG%ROWTYPE;    
BEGIN
    SELECT USER INTO v_log.LG_USUARIO FROM DUAL;
    v_log.LG_ID_ENTIDADE := :NEW.PO_ID;
    v_log.LG_NOME_ENTIDADE := 'TDB2_PRODUTO';
    v_log.LG_DATA_MODIFICACAO := SYSDATE;
    v_log.LG_ANTES_ALTERACAO := :OLD.PO_ESTOQUE;
    v_log.LG_DEPOIS_ALTERACAO := :NEW.PO_ESTOQUE;
    PR_DB1_SAVE_LOG(v_log);
END;

-- Trigger que salva um log quando  ha alteracao na tabela de produto
CREATE OR REPLACE TRIGGER TR_DB1_LOG_PRODUCT    
BEFORE DELETE OR UPDATE ON TDB2_PRODUTO
FOR EACH ROW
DECLARE
    V_LOG TDB3_LOG%ROWTYPE;    
BEGIN    
    SELECT USER INTO V_LOG.LG_USUARIO FROM DUAL;
    V_LOG.LG_ID_ENTIDADE := :OLD.PO_ID;
    V_LOG.LG_NOME_ENTIDADE := 'TDB2_PRODUTO - ' || :OLD.PO_NOME;
    V_LOG.LG_DATA_MODIFICACAO := SYSDATE;
    
    V_LOG.LG_ANTES_ALTERACAO := 
        ' ID:' || :OLD.PO_ID || 
        ' | NOME:' || :OLD.PO_NOME ||
        ' | VALOR:' || :OLD.PO_VALOR ||
        ' | DESCRICAO:' || :OLD.PO_DESCRICAO ||
        ' | CODIGO:' || :OLD.PO_CODIGO ||
        ' | ESTOQUE:' || :OLD.PO_ESTOQUE ||
        ' | N_SERIE:' || :OLD.PO_NUMERO_SERIE ||
        ' | P_LIQUIDO:' || :OLD.PO_PESO_LIQUIDO ||
        ' | P_EMBALAGEM:' || :OLD.PO_PESO_EMBALAGEM ||
        ' | P_DIMENSOES:' || :OLD.PO_DIMENSOES ||
        ' | D_CRIACAO:' || :OLD.PO_DATA_CRIACAO ||  
        ' | D_ATUALIZACAO:' || :OLD.PO_DATA_ATUALIZACAO ||  
        ' | D_DESATIVACAO' || :OLD.PO_DATA_DESATIVACAO ||  
        ' | ATIVO:' || :OLD.PO_ATIVO;
    
    IF UPDATING THEN    
        V_LOG.LG_DEPOIS_ALTERACAO := 
            ' ID:' || :NEW.PO_ID || 
            ' | NOME:' || :NEW.PO_NOME ||
            ' | VALOR:' || :NEW.PO_VALOR ||
            ' | DESCRICAO:' || :NEW.PO_DESCRICAO ||
            ' | CODIGO:' || :NEW.PO_CODIGO ||
            ' | ESTOQUE:' || :NEW.PO_ESTOQUE ||
            ' | N_SERIE:' || :NEW.PO_NUMERO_SERIE ||
            ' | P_LIQUIDO:' || :NEW.PO_PESO_LIQUIDO ||
            ' | P_EMBALAGEM:' || :NEW.PO_PESO_EMBALAGEM ||
            ' | P_DIMENSOES:' || :NEW.PO_DIMENSOES ||
            ' | D_CRIACAO:' || :NEW.PO_DATA_CRIACAO ||  
            ' | D_ATUALIZACAO:' || :NEW.PO_DATA_ATUALIZACAO ||  
            ' | D_DESATIVACAO' || :NEW.PO_DATA_DESATIVACAO ||  
            ' | ATIVO:' || :NEW.PO_ATIVO;
        
    ELSIF DELETING THEN    
        V_LOG.LG_DEPOIS_ALTERACAO := 'PRODUTO EXCLUIDO PELO USUARIO ' || V_LOG.LG_USUARIO;
    END IF;
    
    PR_DB1_SAVE_LOG(V_LOG);
END;