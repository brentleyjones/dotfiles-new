function pubkey -d 'Copies the public key tot he clipboard'
    more "$HOME/.ssh/id_rsa.pub" | pbcopy | echo 'Public key copied to pasteboard.'
end
