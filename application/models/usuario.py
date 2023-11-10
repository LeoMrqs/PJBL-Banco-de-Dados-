from sqlalchemy import Column, Integer, Sequence, String, Enum
from services.db import Base
from sqlalchemy.orm import relationship

class Usuario(Base):
    __tablename__ = 'usuario'

    # Atributos
    id_Usuario = Column('id_Usuario', Integer, Sequence('usuario_id_seq'), primary_key=True, autoincrement=True)
    nome = Column(String(90), nullable=False)
    senha = Column(String(90), nullable=False)
    email = Column(String(90), nullable=False, unique=True)
    tipo = Column(Enum('cliente', 'funcionario'), nullable=False)

    # Relacionamentos
    enderecos = relationship("Endereco", back_populates="usuario")
    clientes = relationship("Cliente", back_populates="usuario", cascade="all, delete")
    carrinho = relationship("Carrinho", back_populates="usuario")
    pedidos = relationship("Pedido", back_populates="usuario")

    def __repr__(self):
        return f"<Usuario(id_Usuario={self.id_Usuario}, nome={self.nome}, email={self.email}, tipo={self.tipo})>"

# id_Usuario: É a chave primária e é autoincremental.
# nome, senha, email: São campos VARCHAR com tamanho máximo de 90 caracteres e são campos não nulos (NN).
# email: É um campo único (UQ), o que significa que dois usuários não podem ter o mesmo e-mail.
# tipo: É um campo ENUM que só pode ter os valores 'cliente' ou 'funcionario'.
