import zmail
from check import check

class ZMailObject(object):

    def __init__(self):
        # 邮箱账号
        self.username = 'xxx@163.com'

        # 邮箱授权码
        self.authorization_code = 'xxxx'

        # 构建一个邮箱服务对象
        self.server = zmail.server(self.username, self.authorization_code)

		# 发送邮件
        self.mail_to = "xxx@qq.com"


    def mail_body(self):
        # 邮件主体
        mail_body = {
            'subject': '巡视报告',
            'content_html':[ check()],# 纯文本或者HTML内容
			# 附件
            # 'attachments': ['d://20200714174905.png'],
        }
        return mail_body


# 发送邮件
mail=ZMailObject()
mail.server.send_mail(mail.mail_to, mail.mail_body())
