CREATE TABLE clientes (
    ID NUMBER PRIMARY KEY,
    Nome VARCHAR2(50),
    Endereco VARCHAR2(100),
    Email VARCHAR2(50),
    Telefone VARCHAR2(20)
);

CREATE TABLE produtos (
    ID NUMBER PRIMARY KEY,
    Nome_Produto VARCHAR2(50),
    Descricao_Produto VARCHAR2(200),
    Preco NUMBER,
    Quantidade_Estoque NUMBER
);

CREATE TABLE pedidos (
    ID NUMBER PRIMARY KEY,
    ID_Cliente NUMBER REFERENCES clientes(ID),
    ID_Produto NUMBER REFERENCES produtos(ID),
    Data_Pedido DATE,
    Quantidade NUMBER,
    Status_Pedido VARCHAR2(50),
    Valor_Total NUMBER
);
