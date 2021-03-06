const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});


const serviceAccount = require("./service/cred.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const firestore = admin.firestore();


exports.sendMail = functions.https.onRequest((req, res) => {
    cors(req, res, async () => {
      


            let querySnapshot= await firestore
      .collection("siteSettings")
      .limit(1)
      .get();

    let transporter=null
    let support_email="chard@excluzeev.com" // Falback support email

      querySnapshot.forEach(snapShot => {
        let settings=snapShot.data();
       
     

            user=settings.email_user;
            support_email=user; // Get from configuration
            password=settings.email_password

            /**
            * Here we're using Gmail to send 
            */
            transporter = nodemailer.createTransport({
                service: 'gmail',
                auth: {
                    user: user,
                    pass: password
                }
            });

       });
        console.log("Email credentials: ",user,password);

        if(transporter == null){
            return res.send('Failed to sent !!');
        }

        // getting dest email by query string
        const user_email = req.query.email;
        const subject = req.query.subject;
        const username = req.query.username;
        const message = req.query.message;





        const mailOptions = {
            from: 'Excluzeev <support@excluzeev.com>', // Something like: Jane Doe <janedoe@gmail.com>
            to: support_email,
            subject: subject, // email subject
            html: 
            `
                <b>Dear support,</b>
                <br />
                <p style="padding-left:30px;"> <b>${username}</b> (${user_email}) has the following query. Kindly check it.</p>

                <p style="padding-left:30px;">
                ${message}
                </p> 
                <br />
                
                <b>With regards,</b>
                <br />
                <b>Excluzeev admin</b>
            ` // email content in HTML
        };
  
        // returning result
        return transporter.sendMail(mailOptions, (erro, info) => {
            if(erro){
                return res.send(erro.toString());
            }
            return res.send('Email sent !!');
        });
    });    
});


