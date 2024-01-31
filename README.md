# chat

Sexto projeto finalizado no curso "Aprenda Flutter e Desenvolva Apps Para Android e IOS 2022".

Com este app, o usuário irá fazer um cadastro e, assim, poderá se juntar a um grupo para trocar mensagens. Este app conta com um login 'automático' utilizando Stream, onde é verificado se o usuário foi desconectado ou não do FirebaseAuth. Então, quando ele fechar e abrir o app, ele ainda estará conectado. Outra Stream utilizada é na hora de receber e enviar mensagens, escutando quaisquer mudanças que ocorrem no Firestore e adiciona as mensagens. E ainda conta com um recurso de receber notificações push do Firebase.

Pacotes utilizados: image_picker, provider, cloud_firestore, firebase_auth, firebase_core, firebase_storage e firebase_messaging.

Versão do Flutter: 3.10.2

![Gif apresentando o projeto](chat.gif)