from sqlalchemy import Column, Integer, String
from services.db import Base
from sqlalchemy.orm import relationship

class Cupom(Base):
    __tablename__ = 'cupom'

    # Atributos
    id_Cupom = Column('id_Cupom', Integer, primary_key=True, autoincrement=True)
    desconto = Column(String(45))
    validade = Column(String(45))
    codigo = Column(String(45))
    status = Column(String(45))

    # Relacionamento
    pedidos = relationship("Pedido", back_populates="cupom")

    def __repr__(self):
        return f"<Cupom(id_Cupom={self.id_Cupom}, desconto={self.desconto}, validade={self.validade}, codigo={self.codigo}, status={self.status})>"

# Explicações:
# id_Cupom: É a chave primária e é autoincremental.
# desconto, validade, codigo, status: São campos VARCHAR com tamanhos máximos de 45 caracteres.
