CREATE OR REPLACE PROCEDURE atualizar_pedido(
idPedido IN NUMBER,
idProduto IN NUMBER,
nova_qtd IN NUMBER,
nova_data_pedido IN DATE
)
IS
    qtd_estoque NUMBER;
    preco NUMBER;
BEGIN
    -- Verifica o estoque do produto 
    SELECT quantidade_estoque, preco 
      INTO qtd_estoque, preco 
      FROM produtos 
     WHERE id = idProduto;
    
	--verifica se a o produto em estoque atende a nova quantidade desejada
    IF qtd_estoque >= nova_qtd THEN
        -- Atualiza os detalhes do pedido na tabela Pedidos:
        UPDATE pedidos 
  	   SET id_produto = idProduto, 
  	       quantidade = nova_qtd, 
	       data_pedido = nova_data_pedido 
	 WHERE id = idPedido;
        
        -- Refletir as alterações no estoque do produto
        UPDATE produtos 
	   SET quantidade_estoque = qtd_estoque - nova_qtd 
	 WHERE id = idProduto;
        
        DBMS_OUTPUT.PUT_LINE('Pedido atualizado com sucesso!');
	COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Produto não tem estoque suficiente.');
    END IF;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
	 DBMS_OUTPUT.PUT_LINE('Produto não existe'); 
    WHEN OTHERS THEN 
         DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLCODE || ' - ' || SQLERRM); 
END;
