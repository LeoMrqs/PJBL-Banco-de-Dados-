from sqlalchemy import Column, Integer, ForeignKey, Enum, Date
from sqlalchemy.orm import relationship
from services.db import Base

class Pagamento(Base):

    # Atributos
    __tablename__ = 'pagamento'
    id_Pagamento = Column('id', Integer, primary_key=True, autoincrement=True, nullable=False)
    id_Pedido = Column(Integer, ForeignKey('pedido.id_Pedido'), nullable=False)  # Relacionamento com Pedido
    tipoPagamento = Column(Enum('crédito', 'debito'), nullable=False)
    dataPagamento = Column(Date, nullable=False)
    status = Column(Enum('pago', 'processando', 'não aprovado'), nullable=False)

    # Relacionamento
    pedidos = relationship("Pedido", back_populates="pagamentos")

    def __repr__(self):
        return f"<Pagamento(id={self.id_Pagamento}, tipo={self.tipoPagamento}, status={self.status})>"
