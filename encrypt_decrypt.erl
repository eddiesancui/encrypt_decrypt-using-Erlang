-module(encrypt_decrypt).
-export([encrypt/2, decrypt/2]).

encrypt(Plain_Text, Key_Text) ->
    Range = length(lists:seq($a, $z)),
    Key_Text_adjusted = string:substr(string:copies(Key_Text, length(Plain_Text)), 1, length(Plain_Text)),
    encrypted_text(Plain_Text, Key_Text_adjusted, [], Range). 

encrypted_text([Plain_Text_Head|Plain_Text_Tail], [Key_Text_Head|Key_Text_Tail], Accumulator1, Range) ->
        PT_KT = ((Plain_Text_Head - 97) + (Key_Text_Head - 97)) rem Range + 97,
        encrypted_text(Plain_Text_Tail, Key_Text_Tail, [PT_KT|Accumulator1], Range);

encrypted_text([], [], Accumulator1, _) ->
    lists:reverse(Accumulator1).


decrypt(Cipher_Text, Key_Text) ->
    Range = length(lists:seq($a, $z)),
    Key_Text_adjusted = string:substr(string:copies(Key_Text, 3), 1, string:len(Cipher_Text)),
    decrypted_text(Cipher_Text, Key_Text_adjusted, [], Range).

decrypted_text([Cipher_text_Head|Cipher_text_tail], [Key_text_head|Key_text_tail], Accumulator2, Range) ->
    CT_KT = (Cipher_text_Head - Key_text_head + 26) rem Range + 97,
    decrypted_text(Cipher_text_tail, Key_text_tail, [CT_KT|Accumulator2], Range);

decrypted_text([], [], Accumulator2, _) ->
    lists:reverse(Accumulator2).

