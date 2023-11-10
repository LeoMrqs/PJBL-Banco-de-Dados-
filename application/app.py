from services.db import engine, Base, SessionLocal
from models import usuario, cliente, endereco, pedido, produto, pagamento, entrega, cupom, carrinho
import random
from sqlalchemy.orm import Session

# Inicializar a sessão
db = SessionLocal()

if __name__ == "__main__":
    # Criar todas as tabelas
    Base.metadata.create_all(bind=engine)

    # #### INSENÇÃO DOS DADOS #### #

    # Inserir 10 usuários
    usuarios_inseridos = []  # Lista para armazenar os objetos de usuários inseridos
    for i in range(1, 11):
        novo_usuario = usuario.Usuario(
            nome=f'Usuario{i}',
            senha=f'Senha{i}',
            email=f'usuario{i}@exemplo.com',
            tipo='cliente' if i <= 5 else 'funcionario'  # Os primeiros 5 serão 'cliente', o resto será 'funcionario'
        )
        db.add(novo_usuario)
        usuarios_inseridos.append(novo_usuario)

    # Confirmar as transações
    db.commit()

    # Inserir 10 endereços
    for i, user in enumerate(usuarios_inseridos, 1):
        novo_endereco = endereco.Endereco(
            id_Usuario=user.id_Usuario,
            complemento=f'Complemento{i}' if i % 2 == 0 else None,  # Adicionar complemento para endereços pares
            bairro=f'Bairro{i}',
            rua=f'Rua{i}',
            numero=f'{i}00',
            cep=f'0000{i}00',
            cidade=f'Cidade{i}'
        )
        db.add(novo_endereco)

    # Inserir 10 clientes
    for i, user in enumerate(usuarios_inseridos, 1):
        novo_cliente = cliente.Cliente(
            Usuario_id=user.id_Usuario,
            cpf=10000000000 + i,
            telefone=f'011-90000-00{i}'
        )
        db.add(novo_cliente)

    # Inserir 10 carrinhos
    for i, user in enumerate(usuarios_inseridos, 1):
        novo_carrinho = carrinho.Carrinho(
            Usuario_id=user.id_Usuario
        )
        db.add(novo_carrinho)

    # Inserir 6 cupons
    for i in range(1, 7):
        novo_cupom = cupom.Cupom(
            desconto='10%',
            validade='2023-12-31',
            codigo=f'CUPOM{i}',
            status='ativo'
        )
        db.add(novo_cupom)

    # Confirmar as transações
    db.commit()

    # Inserir 6 pedidos
    for i in range(1, 7):
        novo_pedido = pedido.Pedido(
            id_Carrinho=i,
            Usuario_id=i,
            status=1,
            valorTotal='100.00',
            frete='10.00',
            dataHora='2023-01-01 12:00:00',
            id_Cupom=i
        )
        db.add(novo_pedido)

    db.commit()

    # Inserir 6 entregas
    enderecos_inseridos = db.query(endereco.Endereco).all()
    pedidos_inseridos = db.query(pedido.Pedido).all()
    for i, (end, ped) in enumerate(zip(enderecos_inseridos, pedidos_inseridos), 1):
        if i > 6:  # Limitar a 6 entregas
            break
        nova_entrega = entrega.Entrega(
            id_Endereco=end.id_Endereco,
            id_Pedido=ped.id_Pedido,
            status=f'Em trânsito',
            dataEstimada=f'2023-01-{10 + i}'
        )
        db.add(nova_entrega)

    # Inserir 10 produtos
    produtos_inseridos = []  # Lista para armazenar os objetos de produtos inseridos
    for i in range(1, 11):
        novo_produto = produto.Produto(
            nome=f'Produto{i}',
            preco=f'{10 + i}.00',
            descricao=f'Descricao do Produto{i}',
            categoria=f'Categoria{i}',
            estoque=100
        )
        db.add(novo_produto)
        produtos_inseridos.append(novo_produto)  # Adicionar o produto à lista

    # Inserir 6 pagamentos
    tipos_pagamento = ['crédito', 'debito']
    status_pagamento = ['pago', 'processando', 'não aprovado']
    pedidos_inseridos = db.query(pedido.Pedido).all()  # Buscar todos os pedidos inseridos
    for i, ped in enumerate(pedidos_inseridos, 1):
        if i > 6:  # Limitar a 6 pagamentos
            break
        novo_pagamento = pagamento.Pagamento(
            id_Pedido=ped.id_Pedido,
            tipoPagamento=random.choice(tipos_pagamento),  # Escolher aleatoriamente entre 'credito' e 'debito'
            dataPagamento='2023-01-01',
            status=random.choice(status_pagamento)
            # Escolher aleatoriamente entre 'pago', 'processando' e 'não aprovado'
        )
        db.add(novo_pagamento)

    db.commit()

    # #### ATUALIZAÇÃO DE REGISTRO #### #

    # Atualizar 5 usuários para tipo "admin"
    usuarios_para_atualizar = db.query(usuario.Usuario).limit(5).all()
    for user in usuarios_para_atualizar:
        user.tipo = 'cliente'

    # Atualizar o bairro de 5 endereços
    enderecos_para_atualizar = db.query(endereco.Endereco).limit(5).all()
    for end in enderecos_para_atualizar:
        end.bairro = 'Novo Bairro'

    # Atualizar o telefone de 5 clientes
    clientes_para_atualizar = db.query(cliente.Cliente).limit(5).all()
    for cli in clientes_para_atualizar:
        cli.telefone = '011-11111-1111'

    # Atualizar o status de 5 pedidos
    pedidos_para_atualizar = db.query(pedido.Pedido).limit(5).all()
    for ped in pedidos_para_atualizar:
        ped.status = 2

    # Atualizar o estoque de 5 produtos
    produtos_para_atualizar = db.query(produto.Produto).limit(5).all()
    for prod in produtos_para_atualizar:
        prod.estoque = 50

    db.commit()

    # #### INSTRUÇÕES DE EXCLUSÃO #### #

    cupom_para_excluir = db.query(cupom.Cupom).filter(cupom.Cupom.id_Cupom == 1).first()
    if cupom_para_excluir:
        db.delete(cupom_para_excluir)
        db.commit()

    produto_para_excluir = db.query(produto.Produto).filter(produto.Produto.id_Produto == 1).first()
    if produto_para_excluir:
        db.delete(produto_para_excluir)
        db.commit()

    # #### CONSULTAS #### #

    clientes_cpf_ordenados = cliente.Cliente.get_all_ordered_by_cpf(db) # Ordenar todos os CPF
    for cliente in clientes_cpf_ordenados:
        print(cliente)

    db.commit()

    cpf_to_search = 10000000005  # Substitua pelo CPF que você quer buscar / Buscar por CPF
    clientes_by_cpf = cliente.get_by_cpf(db, cpf_to_search)
    print('---------------')
    for cliente in clientes_by_cpf:
        print(cliente)

    db.commit()

    all_phones = cliente.get_all_phones(db) # Buscar todos os telefones
    print('---------------')
    for phone in all_phones:
        print(phone)

    db.commit()

    all_status = entrega.Entrega.get_all_status(db) # Todos os status de entrega
    print('---------------')
    for status in all_status:
        print(status)

    db.commit()

    all_estimated_dates = entrega.Entrega.get_all_estimated_dates_ordered(db) # dataEstimada ordenado
    print('---------------')
    for date in all_estimated_dates:
        print(date)

    db.commit()

    all_cities = endereco.Endereco.get_all_cities(db) # Buscar todas as cidades
    print('---------------')
    for city in all_cities:
        print(city)

    db.commit()

    cep_to_search = "0000400"  # Substitua pelo CEP que você quer buscar / Buscar por CEP específico
    endereco_by_cep = endereco.Endereco.get_by_cep(db, cep_to_search)
    print('---------------')
    if endereco_by_cep:
        print(endereco_by_cep)
    else:
        print(f"Nenhum endereço encontrado para o CEP {cep_to_search}")

    db.commit()

    all_product_names = produto.Produto.get_all_product_names(db)  # Buscar todos os nomes dos produtos
    print('---------------')
    for product_name in all_product_names:
        print(product_name)

    db.commit()

    products_ordered_by_stock = produto.Produto.get_all_ordered_by_stock(db) # Buscar todos os produtos ordenados por estoque
    print('---------------')
    for product in products_ordered_by_stock:
        print(product)

    db.commit()

    user_id_to_search = 1  # substitua pelo ID do usuário que você deseja buscar / Buscar todos os pedidos de um usuário específico
    orders_by_user = pedido.Pedido.get_all_by_user_id(db, user_id_to_search)
    print('---------------')
    for order in orders_by_user:
        print(order)

    db.commit()

    status_to_search = 1  # substitua pelo status que você deseja buscar / Buscar todos os pedidos com um status específico
    orders_by_status = pedido.Pedido.get_all_by_status(db, status_to_search)
    print('---------------')
    for order in orders_by_status:
        print(order)

    db.commit()

    value_to_search = 20  # substitua pelo valor que você deseja usar como limite / Buscar todos os pedidos com valor total acima de um certo valor
    orders_above_value = pedido.Pedido.get_all_above_total_value(db, value_to_search)
    print('---------------')
    for order in orders_above_value:
        print(order)

    # Confirmar as transações
    db.commit()

    # Fechar a sessão
    db.close()
