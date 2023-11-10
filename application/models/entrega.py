from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, Session
from services.db import Base, SessionLocal, engine


class Entrega(Base):
    __tablename__ = 'entrega'

    # Atributo
    id_Entrega = Column('id_Entrega', Integer, primary_key=True, autoincrement=True)
    id_Endereco = Column(Integer, ForeignKey('endereco.id_Endereco'), nullable=False)
    id_Pedido = Column(Integer, ForeignKey('pedido.id_Pedido'), nullable=False)
    status = Column(String(45))
    dataEstimada = Column(String(45))

    # Relacionamentos
    enderecos = relationship("Endereco", back_populates="entregas")
    pedidos = relationship("Pedido", back_populates="entregas")

    def __repr__(self):
        return f"<Entrega(id_Entrega={self.id_Entrega}, id_Endereco={self.id_Endereco}, id_Pedido={self.id_Pedido}, status={self.status}, dataEstimada={self.dataEstimada})>"

    # Metodos

    @classmethod
    def get_all_status(cls, db):
        return db.query(cls.status).all()

    @classmethod
    def get_all_estimated_dates_ordered(cls, db):
        return db.query(cls.dataEstimada).order_by(cls.dataEstimada).all()

# Explicações:
# id_Entrega: É a chave primária e é autoincremental.
# id_Endereco, id_Pedido: São chaves estrangeiras que se referem às respectivas tabelas.
# status, dataEstimada: São campos adicionais da entrega.
