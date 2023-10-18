CREATE OR REPLACE PROCEDURE criar_pedido(
idCliente IN NUMBER,
idProduto IN NUMBER,
quantidade IN NUMBER,
data_pedido IN DATE
)
IS
    qtd_estoque NUMBER;
	preco_produto NUMBER;
	
BEGIN
    -- Verifica se o produto está em estoque na quantidade desejada
    SELECT quantidade_estoque, preco 
	INTO qtd_estoque, preco_produto
	FROM produtos 
	WHERE id = idProduto;
    
    IF qtd_estoque >= quantidade THEN

        -- Cria um novo registro na tabela Pedidos com os detalhes do pedido:
        INSERT INTO pedidos (id, id_cliente, id_produto, data_pedido, quantidade, status_pedido, valor_total) 
		VALUES (seq_id_pedido.nextval, idCliente, idProduto, data_pedido, quantidade, 'Em Processamento', (quantidade*preco_produto));
        
        -- Atualiza o estoque do produto:
        UPDATE produtos 
		   SET quantidade_estoque = qtd_estoque - quantidade 
		 WHERE id = idProduto;
        
        DBMS_OUTPUT.PUT_LINE('Pedido criado com sucesso!');
		COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Produto fora de estoque.');
    END IF;

    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Produto não existe'); 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLCODE || ' - ' || SQLERRM); 
END;