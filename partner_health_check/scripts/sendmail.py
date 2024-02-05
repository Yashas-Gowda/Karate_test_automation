import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime

def send_email_with_attachment(to_email, subject, body, attachment_path):

    print(f"Running sendmail script")

    # Gmail account credentials
    gmail_username = 'roopa@monnai.com'
    gmail_password = 'jixf niwr ojlp sqhz'

    # Email configuration
    from_email = gmail_username

    message = MIMEMultipart()
    #message['From'] = from_email
    message['To'] = ', '.join(to_email)
    message['To'] = to_email
    message['Subject'] = subject

    # Attach the body of the email (as HTML)
    message.attach(MIMEText(body, 'html'))

    """
    # Attach the HTML file
    attachment = open(attachment_path, 'rb')
    part = MIMEBase('application', 'octet-stream')
    part.set_payload((attachment).read())
    encoders.encode_base64(part)
    part.add_header('Content-Disposition', f"attachment; filename= {attachment_path}")
    message.attach(part)
    """

    # Attach the zip file
    attachment = open(attachment_path, 'rb')
    part = MIMEBase('application', 'zip')
    part.set_payload((attachment).read())
    encoders.encode_base64(part)
    part.add_header('Content-Disposition', f"attachment; filename= {attachment_filename}")
    message.attach(part)

    print(f"before mail")

    # Establish a connection to the SMTP server
    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        # Start TLS for security
        server.starttls()

        # Login to the Gmail account
        server.login(gmail_username, gmail_password)

        # Send the email
        server.sendmail(from_email, to_email, message.as_string())

    print(f"Email with HTML file attachment sent to {to_email} successfully.")

# Get current date and time
current_datetime = datetime.now()

formatted_date = current_datetime.strftime("%d-%m-%Y")

#to_email = 'roopa@monnai.com'
to_email = ['roopa@monnai.com', 'sameena@monnai.com', 'sk@monnai.com', 'siddhesh@monnai.com', 'anuj@monnai.com', 'sonal@monnai.com', 'sanjaya@monnai.com', 'tapan@monnai.com', 'anjan@monnai.com']

subject = f"Partner health check report - {formatted_date}"

body = '<p>Partner health check test results attached with this mail.</p>'

#attachment_path = '/home/ec2-user/results.zip'
attachment_path = '/home/ec2-user/partner_health_check/partner_health_check.zip'
attachment_filename = f"partner_health_check_{formatted_date}.zip"

print(f"Email with HTML file attachment sent to {to_email} - {subject} - {body} - {attachment_path} - {attachment_filename} ")

send_email_with_attachment(to_email, subject, body, attachment_path)

