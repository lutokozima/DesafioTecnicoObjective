CREATE OR REPLACE FUNCTION historico_pedidos_cliente(
idCliente IN NUMBER
) 
RETURN 
SYS_REFCURSOR

IS
    pedidos SYS_REFCURSOR;
BEGIN
    -- retornar registro de histórico de todos os pedidos do cliente
    OPEN pedidos 
	FOR
        SELECT p.id, p.data_pedido, p.status_pedido, p.valor_total
        FROM pedidos p
        WHERE p.id_cliente = idCliente;
    
    RETURN pedidos;
    
    EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLCODE || ' - ' || SQLERRM); 
END;
