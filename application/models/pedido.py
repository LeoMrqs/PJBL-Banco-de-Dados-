from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, Session
from services.db import Base, SessionLocal, engine


class Pedido(Base):
    __tablename__ = 'pedido'

    # Atributos
    id_Pedido = Column('id_Pedido', Integer, primary_key=True, autoincrement=True)
    id_Carrinho = Column(Integer, ForeignKey('carrinho.id_Carrinho'), nullable=False)
    Usuario_id = Column(Integer, ForeignKey('usuario.id_Usuario'), nullable=False)
    status = Column(Integer)
    valorTotal = Column(String(45))
    frete = Column(String(45))
    dataHora = Column(String(45))
    id_Cupom = Column(Integer, ForeignKey('cupom.id_Cupom'))

    # Relacionamentos
    carrinho = relationship("Carrinho", back_populates="pedidos")
    usuario = relationship("Usuario", back_populates="pedidos")
    cupom = relationship("Cupom", back_populates="pedidos")
    entregas = relationship("Entrega", back_populates="pedidos")
    pagamentos = relationship("Pagamento", back_populates="pedidos")

    def __repr__(self):
        return f"<Pedido(id_Pedido={self.id_Pedido}, id_Carrinho={self.id_Carrinho}, Usuario_id={self.Usuario_id}, status={self.status}, valorTotal={self.valorTotal}, frete={self.frete}, dataHora={self.dataHora}, id_Cupom={self.id_Cupom})>"

    # Metodo

    @classmethod
    def get_all_by_user_id(cls, db, user_id):
        return db.query(cls).filter(cls.Usuario_id == user_id).all()

    @classmethod
    def get_all_by_status(cls, db, status):
        return db.query(cls).filter(cls.status == status).all()

    @classmethod
    def get_all_above_total_value(cls, db, value):
        return db.query(cls).filter(cls.valorTotal > value).all()

# Explicações:
# d_Pedido: É a chave primária e é autoincremental.
# id_Carrinho, Usuario_id, id_Cupom: São chaves estrangeiras que se referem às respectivas tabelas.
# status, valorTotal, frete, dataHora: São campos adicionais do pedido.
