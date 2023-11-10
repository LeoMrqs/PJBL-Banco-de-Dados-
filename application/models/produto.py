from sqlalchemy import Column, Integer, String, Sequence, DECIMAL, Text
from services.db import Base, SessionLocal, engine
from sqlalchemy.orm import relationship, Session

class Produto(Base):
    __tablename__ = 'produto'

    # Atributos
    id_Produto = Column(Integer, Sequence('produto_id_seq'), primary_key=True, autoincrement=True, nullable=False)
    nome = Column(String(255), nullable=False)
    preco = Column(DECIMAL(10, 2), nullable=False)
    descricao = Column(Text, nullable=False)
    categoria = Column(String(255), nullable=False)
    estoque = Column(Integer, nullable=False)

    def __repr__(self):
        return f"<Produto(id={self.id_Produto}, nome={self.nome}, preco={self.preco}, descricao={self.descricao}, categoria={self.categoria}, estoque={self.estoque})>"

    # Metodos

    @classmethod
    def get_all_product_names(cls, db: Session):
        return db.query(cls.nome).all()

    @classmethod
    def get_all_ordered_by_stock(cls, db: Session):
        return db.query(cls).order_by(cls.estoque).all()