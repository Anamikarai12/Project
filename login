from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)
app.secret_key = 'your_secret_key'  

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        if username == 'admin' and password == 'password123':
            return redirect(url_for('dashboard'))
        else:
            flash('Invalid username or password.')
            return redirect(url_for('login'))
    
    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    return "Welcome to the Admin Dashboard."


#Book issue
@app.route('/issue_book', methods=['GET', 'POST'])
def issue_book():
    if request.method == 'POST':
        book_name = request.form['book_name']
        author_name = request.form['author_name']
        issue_date = request.form['issue_date']
        return_date = request.form['return_date']
        
       
        if not book_name or not author_name or not issue_date or not return_date:
            flash('All fields must be filled out.')
            return redirect(url_for('issue_book'))
        
        
        if issue_date < str(datetime.date.today()):
            flash('Issue Date cannot be less than today.')
            return redirect(url_for('issue_book'))
        
        
        flash('Book issued successfully!')
        return redirect(url_for('dashboard'))
    
    return render_template('issue_book.html')

#form validation 

@app.route('/return_book', methods=['GET', 'POST'])
def return_book():
    if request.method == 'POST':
        book_name = request.form['book_name']
        serial_no = request.form['serial_no']
        issue_date = request.form['issue_date']
        return_date = request.form['return_date']
        
        
        if not book_name or not serial_no or not issue_date or not return_date:
            flash('All fields must be filled out.')
            return redirect(url_for('return_book'))
        
        
        if return_date < issue_date:
            flash('Return Date cannot be earlier than Issue Date.')
            return redirect(url_for('return_book'))
        
        flash('Book returned successfully!')
        return redirect(url_for('dashboard'))
    
    return render_template('return_book.html')


if __name__ == '__main__':
    app.run(debug=True)
