"""empty message

Revision ID: 965163a2adef
Revises: 1b7a04962b25
Create Date: 2017-06-01 22:26:00.773000

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '965163a2adef'
down_revision = '1b7a04962b25'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('category_pid', sa.Column('category_id', sa.Integer(), nullable=False))
    op.drop_constraint(u'category_pid_ibfk_1', 'category_pid', type_='foreignkey')
    op.create_foreign_key(None, 'category_pid', 'categorys', ['category_id'], ['id'])
    op.drop_column('category_pid', 'category_self')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('category_pid', sa.Column('category_self', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False))
    op.drop_constraint(None, 'category_pid', type_='foreignkey')
    op.create_foreign_key(u'category_pid_ibfk_1', 'category_pid', 'categorys', ['category_self'], ['id'])
    op.drop_column('category_pid', 'category_id')
    # ### end Alembic commands ###