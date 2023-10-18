CREATE OR REPLACE FUNCTION calcular_total_pedido(
idPedido IN NUMBER
) 
RETURN NUMBER 

IS
    vlr_tot_pedido NUMBER;

BEGIN

	--o valor total do pedido considerando preço do produto e a quantidade
    SELECT SUM(p.quantidade * pr.preco) 
	  INTO vlr_tot_pedido
      FROM pedidos p
      JOIN produtos pr 
	    ON p.id_produto = pr.id
     WHERE p.id = idPedido;
    
    RETURN vlr_tot_pedido;
	
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLCODE || ' - ' || SQLERRM); 
	
END;