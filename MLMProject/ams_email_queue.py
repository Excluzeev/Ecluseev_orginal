from mailqueue.models import MailerMessage

# Create your views here.

def send_queue_mail(subject, text_content, html_content=None, sender='', recipient='', image_path=None, image_name=None):
    my_email = sender
    my_name = sender

    msg = MailerMessage()
    msg.subject = subject
    msg.to_address = recipient if isinstance(recipient, list) else [recipient]

    # For sender names to be displayed correctly on mail clients, simply put your name first
    # and the actual email in angle brackets 
    msg.from_address = '{} <{}>'.format(my_name, my_email)

    # As this is only an example, we place the text content in both the plaintext version (content) 
    # and HTML version (html_content).
    msg.content = text_content
    msg.html_content = html_content
    msg.save()