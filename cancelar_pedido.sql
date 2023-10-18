CREATE OR REPLACE PROCEDURE cancelar_pedido(
idPedido IN NUMBER
)
IS
    id_prod NUMBER;
    qtd_pedido NUMBER;

BEGIN
    
    -- Busca a quantidade que está no pedido cancelado
    SELECT id_produto, quantidade 
	  INTO id_prod, qtd_pedido 
	  FROM pedidos 
	 WHERE id = idPedido;

    -- Atualiza o status do pedido para: Cancelado na tabela Pedidos
    UPDATE pedidos 
	   SET status_pedido = 'Cancelado' 
	 WHERE id = idPedido;
	
	-- Restaurar a quantidade do produto no estoque
    UPDATE produtos 
	   SET quantidade_estoque = quantidade_estoque + qtd_pedido 
	 WHERE id = id_prod;
    
    DBMS_OUTPUT.PUT_LINE('Pedido cancelado com sucesso!');
    COMMIT;
    
    EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Pedido não existe'); 	
        WHEN OTHERS THEN 
			Rollback;
            DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLCODE || ' - ' || SQLERRM); 
END;
