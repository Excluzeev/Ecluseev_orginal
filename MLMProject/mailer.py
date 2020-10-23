from django.core import mail
from django.core.mail import EmailMessage
from django.template.loader import get_template
from django.conf import settings

from email.mime.image import MIMEImage
from django.core.mail import EmailMultiAlternatives

class Mailer:

    """
    Send email messages helper class
    """

    def __init__(self, from_email=None):
        # TODO setup the default from email
        self.connection = mail.get_connection()
        if not from_email:
            self.from_email = settings.EMAIL_HOST_USER
        else:
            self.from_email = from_email

    def send_messages(self, subject, template, context, to_emails=[],cc_recipient=[],bcc_recipient=[],is_send_to_support=False,image_path=None,image_name=None,is_support_in_bcc=False,is_support_in_cc=False,attachment_path=None,attachment_name=None):


        print("To emails",to_emails)
        messages = self.__generate_messages(subject, template, context, to_emails,cc_recipient,bcc_recipient,image_path,image_name,attachment_path=attachment_path,attachment_name=attachment_path)
        self.__send_mail(messages)

    def __send_mail(self, mail_messages):
        """
        Send email messages
        :param mail_messages:
        :return:
        """
        self.connection.open()
        self.connection.send_messages(mail_messages)
        self.connection.close()

    def __generate_messages(self, subject, template, context={}, to_emails=[],cc_recipient=[],bcc_recipient=[], image_path=None, image_name=None,attachment_path=None,attachment_name=None):
        """
        Generate email message from Django template
        :param subject: Email message subject
        :param template: Email template
        :param to_emails: to email address[es]
        :return:
        """
        messages = []
        message_template = get_template(template)
        print("context", context)
        for recipient in to_emails:
            message_content = message_template.render(context)
            # message = EmailMessage(subject, message_content, to=[recipient], from_email=self.from_email)
            # message.content_subtype = 'html'
            #
            # if image_path:
            #     message.attach_file(image_path)
            email = EmailMultiAlternatives(subject=subject, body="", from_email=self.from_email,
                                           to=[recipient],cc=cc_recipient,bcc=bcc_recipient)

            email.attach_alternative(message_content, "text/html")
            email.content_subtype = 'html'  # set the primary content to be text/html
            email.mixed_subtype = 'related'  # it is an important part that ensures embedding of an image

            if image_path:
                with open(image_path, mode='rb') as f:
                    image = MIMEImage(f.read())
                    image.add_header('Content-ID', '<{}>'.format(image_name))
                    email.attach(image)

            if attachment_path:
                with open(attachment_path, mode='rb') as f:
                    attachment =f.read()
                    email.attach(attachment_name,attachment)

            # # logo
            # logo_path = "static/img/imgpsh_fullsize.png"
            # logo_image_name = "imgpsh_fullsize.png"
            # with open(logo_path, mode='rb') as f:
            #     image = MIMEImage(f.read())
            #     image.add_header('Content-ID', '<{}>'.format(logo_image_name))
            #     image.add_header("Content-Disposition", "inline", filename=f"<{logo_image_name}>")
            #     email.attach(image)

            messages.append(email)


        return messages