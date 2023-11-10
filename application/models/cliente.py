from sqlalchemy import Column, Integer, ForeignKey, BigInteger, String
from sqlalchemy.orm import relationship, Session
from services.db import Base, SessionLocal, engine

class Cliente(Base):
    __tablename__ = 'cliente'

    # Atributos
    Usuario_id = Column(Integer, ForeignKey('usuario.id_Usuario'), primary_key=True, nullable=False)
    cpf = Column(BigInteger, nullable=False, unique=True)
    telefone = Column(String(15), nullable=False)

    # Relacionamento
    usuario = relationship("Usuario", back_populates="clientes")

    def __repr__(self):
        return f"<Cliente(Usuario_id={self.Usuario_id}, cpf={self.cpf}, telefone={self.telefone})>"

    # Metodos

    @classmethod
    def get_all_ordered_by_cpf(cls, db: Session):
        return db.query(cls).order_by(cls.cpf).all()

    @classmethod
    def get_by_cpf(cls, db: Session, cpf: int):
        return db.query(cls).filter(cls.cpf == cpf).all()

    @classmethod
    def get_all_phones(cls, db: Session):
        return db.query(cls.telefone).all()

# Explicações:
# Usuario_id: É uma chave estrangeira que se refere ao id_Usuario na tabela Usuario. Também é a chave primária nesta tabela.
# cpf: É um campo BIGINT que é não nulo e único.
# telefone: É um campo VARCHAR(15) que é não nulo e único.
