const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
admin.initializeApp();

/**
* Here we're using Gmail to send 
*/
let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'ananthakannan14@gmail.com',
        pass: 'fybwepqghtmacmmm'
    }
});

exports.sendMail = functions.https.onRequest((req, res) => {
    cors(req, res, () => {
      
        // getting dest email by query string
        const dest = req.query.dest;
        const subject = req.query.subject;
        const username = req.query.username;
        const message = req.query.message;


        const mailOptions = {
            from: 'Excluzeev <excluzeevsupport@gmail.com>',
            to: dest,
            subject: subject, // email subject
            html: 
            `
                <b>Dear support,</b>
                <br />
                <p style="padding-left:30px;"> <b>${username}</b> (${dest}) has the following query. Kindly check it.</p>

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
