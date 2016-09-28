# all the imports
import os
import sqlite3
from flask import Flask, request, session, g, redirect, url_for, abort, \
     render_template, flash

# create our little application :)
app = Flask(__name__)
app.config.from_object(__name__)

# Load default config and override config from an environment variable
app.config.update(dict(
    DATABASE=os.path.join(app.root_path, 'flaskr.db'),
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='default'
))

app.config.from_envvar('FLASKR_SETTINGS', silent=True)


def connect_db():
    """Connects to the specific database."""
    rv = sqlite3.connect(app.config['DATABASE'])
    rv.row_factory = sqlite3.Row
    return rv


def get_db():
    """Opens a new database connection if there is none yet for the
    current application context.
    """
    if not hasattr(g, 'sqlite_db'):
        g.sqlite_db = connect_db()
    return g.sqlite_db


@app.teardown_appcontext
def close_db(error):
    """Closes the database again at the end of the request."""
    if hasattr(g, 'sqlite_db'):
        g.sqlite_db.close()


def init_db():
    db = get_db()
    with app.open_resource('test.sql', mode='r') as f:
        db.cursor().executescript(f.read())
    db.commit()


@app.cli.command('initdb')
def initdb_command():
    """Initializes the database."""
    init_db()
    print 'Initialized the database.'


@app.route('/')
def home():
    db = get_db()
    cur = db.execute('select * from SALE')
    sales = cur.fetchall()
    cur = db.execute('select * from PRODUCT')
    products = cur.fetchall()
    return render_template('home.html', sales=sales, products=products)

@app.route('/sale', methods=['POST'])
def sale():
    id = request.form['prod_id']
    db = get_db()
    db.execute('INSERT INTO SALE(SALE_ID, PROD_ID, CUST_ID, SALE_QUANTITY, SALE_BALANCE) VALUES(2,35, 9, 116, 0.00)')
    return redirect(url_for('home'))

# create the show page for products
@app.route('/products')
def show_products():
    db = get_db()
    cur = db.execute('select * from PRODUCT order by PROD_ID asc')
    products = cur.fetchall()
    return render_template('products.html', products=products)


# create the show page for customers
@app.route('/customers')
def show_customers():
    db = get_db()
    cur = db.execute('select * from CUSTOMER order by CUST_ID asc')
    customers = cur.fetchall()
    return render_template('customers.html', customers=customers)


# create the show page for suppliers
@app.route('/suppliers')
def show_suppliers():
    db = get_db()
    cur = db.execute('select * from SUPPLIER order by SUPPLIER_ID asc')
    suppliers = cur.fetchall()
    return render_template('supplier.html', suppliers=suppliers)


# create the show page for suppliers
@app.route('/ads')
def show_ads():
    db = get_db()
    cur = db.execute('select * from ADVERTISEMENT order by AD_ID asc')
    ads = cur.fetchall()
    return render_template('ads.html', ads=ads)


@app.route('/add', methods=['POST'])
def add_entry():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    db.execute('insert into entries (title, text) values (?, ?)',
                 [request.form['title'], request.form['text']])
    db.commit()
    flash('New entry was successfully posted')
    return redirect(url_for('show_entries'))


@app.route('/add_products', methods=['POST'])
def add_products():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    try:
        db.execute('INSERT INTO PRODUCT(PROD_ID, PROD_NAME, PROD_DESCRIPTION, PROD_PRICE, PROD_QUANTITY) values (?, ?, ?, ?, ?)',
                     [request.form['prod_id'], request.form['prod_name'],  request.form['prod_description'],
                      request.form['prod_price'], request.form['prod_quantity']])

        flash('New product was successfully posted')
        db.commit()
    except:
        flash('Error: could not add that product')
        pass
    return redirect(url_for('show_products'))


@app.route('/add_customers', methods=['POST'])
def add_customers():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    try:
        db.execute('INSERT INTO CUSTOMER(CUST_ID, CUST_NAME, CUST_DOB, CUST_ADDRESS) values (?, ?, ?, ?)',
                     [request.form['cust_id'], request.form['cust_name'],  request.form['cust_dob'],
                      request.form['cust_address']])

        flash('New customer was successfully posted')
        db.commit()
    except:
        flash('Error: could not add that customer')
        pass
    return redirect(url_for('show_customers'))


@app.route('/add_supplier', methods=['POST'])
def add_supplier():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    try:
        db.execute('INSERT INTO SUPPLIER(SUPPLIER_ID, SUPPLIER_NAME, SUPPLIER_LOCATION)  values (?, ?, ?)',
                     [request.form['supplier_id'], request.form['supplier_name'],  request.form['supplier_location']])

        flash('New supplier was successfully posted')
        db.commit()
    except:
        flash('Error: could not add that supplier')
        pass
    return redirect(url_for('show_suppliers'))


@app.route('/add_advertisement', methods=['POST'])
def add_advertisement():
    if not session.get('logged_in'):
        abort(401)
    db = get_db()
    try:
        db.execute('INSERT INTO ADVERTISEMENT(AD_ID, AD_NAME, AD_DESCRIPTION)  values (?, ?, ?)',
                     [request.form['ad_id'], request.form['ad_name'],  request.form['ad_description']])

        flash('New Ad was successfully posted')
        db.commit()
    except:
        flash('Error: could not add that Advertisement')
        pass
    return redirect(url_for('show_ads'))



@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        if request.form['username'] != app.config['USERNAME']:
            error = 'Invalid username'
        elif request.form['password'] != app.config['PASSWORD']:
            error = 'Invalid password'
        else:
            session['logged_in'] = True
            flash('You were logged in')
            return redirect(url_for('show_entries'))
    return render_template('login.html', error=error)


@app.route('/logout')
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('show_entries'))


if __name__ == '__main__':
    app.run()
