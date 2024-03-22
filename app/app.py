from flask import Flask, jsonify, render_template

app = Flask(__name__, template_folder='templates')


@app.route('/')
def index():
    return render_template('index.html')


a = 5000


@app.route("/health")
def health():
    # Add any meta-information you want to include here
    return jsonify({
        'status': 'OK',
        'version': '1.0',
        'description': 'Flask Application Health Check'
    })


if __name__ == '__main__':
    app.run(debug=True, use_reloader=True, host='0.0.0.0')
