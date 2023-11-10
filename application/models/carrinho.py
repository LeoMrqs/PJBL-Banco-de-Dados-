from sqlalchemy import Column, Integer, ForeignKey
from sqlalchemy.orm import relationship
from services.db import Base


class Carrinho(Base):
    __tablename__ = 'carrinho'

    # Atributo
    id_Carrinho = Column('id_Carrinho', Integer, primary_key=True, autoincrement=True)
    Usuario_id = Column(Integer, ForeignKey('usuario.id_Usuario'), nullable=False)

    # Relacionamento
    usuario = relationship("Usuario", back_populates="carrinho")
    pedidos = relationship("Pedido", back_populates="carrinho")

    def __repr__(self):
        return f"<Carrinho(id_Carrinho={self.id_Carrinho}, Usuario_id={self.Usuario_id})>"

# Explicações:
# id_Carrinho: É a chave primária e é autoincremental.
# Usuario_id: É uma chave estrangeira que se refere ao id_Usuario na tabela Usuario.
