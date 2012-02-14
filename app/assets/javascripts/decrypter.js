function decrypt(ciphertext, key)
{
    var cipher_ascii = new Array();
    cipher_ascii = ciphertext.split(".");
    var plaintext = new String();

    for(var count=1; count<cipher_ascii.length; count++)
    {

        plaintext+=String.fromCharCode(cipher_ascii[count]^key.charCodeAt((count-1)%key.length));
    }

    return plaintext;
}