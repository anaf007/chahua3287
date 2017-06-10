"""empty message

Revision ID: 8a9d0b76aee7
Revises: 23ce681ccaa0
Create Date: 2017-06-10 14:25:47.276116

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '8a9d0b76aee7'
down_revision = '23ce681ccaa0'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('category_top', sa.Column('category_attribute_id', sa.Integer(), nullable=True))
    op.create_foreign_key(None, 'category_top', 'category_attribute', ['category_attribute_id'], ['id'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'category_top', type_='foreignkey')
    op.drop_column('category_top', 'category_attribute_id')
    # ### end Alembic commands ###
