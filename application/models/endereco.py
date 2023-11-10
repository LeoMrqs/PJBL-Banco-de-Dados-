from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, Session
from services.db import Base, SessionLocal, engine


class Endereco(Base):
    __tablename__ = 'endereco'

    # Atributos
    id_Endereco = Column('id_Endereco', Integer, primary_key=True, autoincrement=True)
    id_Usuario = Column(Integer, ForeignKey('usuario.id_Usuario'), nullable=False)
    complemento = Column(String(255), nullable=True)
    bairro = Column(String(45), nullable=False)
    rua = Column(String(255), nullable=False)
    numero = Column(String(45), nullable=False)
    cep = Column(String(45), nullable=False)
    cidade = Column(String(45), nullable=False)

    # Relacionamento
    usuario = relationship("Usuario", back_populates="enderecos")
    entregas = relationship("Entrega", back_populates="enderecos")

    def __repr__(self):
        return f"<Endereco(id_Endereco={self.id_Endereco}, rua={self.rua}, numero={self.numero}, cep={self.cep}, cidade={self.cidade})>"

    # Metodo

    @classmethod
    def get_all_cities(cls, db: Session):
        return db.query(cls.cidade).distinct().all()

    @classmethod
    def get_by_cep(cls, db: Session, cep_to_search):
        return db.query(cls).filter(cls.cep == cep_to_search).first()

# Explicações:
# id_Endereco: É a chave primária e é autoincremental.
# id_Usuario: É uma chave estrangeira que se refere ao id_Usuario na tabela Usuario.
# complemento: É um campo que pode ser nulo.
# bairro, rua, numero, cep, cidade: São campos VARCHAR com tamanhos máximos específicos e são campos não nulos.
