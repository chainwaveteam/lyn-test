declare -a ADRESSES=(
    # "erd1qyu5wthldzr8wx5c9ucg8kjagg0jfs53s8nr3zpz3hypefsdd8ssycr6th"
    # "erd1spyavw0956vq68xj8y4tenjpq2wd5a9p2c6j8gsz7ztyrnpxrruqzu66jx"
    # "erd1dc3yzxxeq69wvf583gw0h67td226gu2ahpk3k50qdgzzym8npltq7ndgha"
    "erd1k2s324ww2g0yj38qn2ch2jwctdy8mnfxep94q9arncc6xecg3xaq6mjse8"
    "erd18tudnj2z8vjh0339yu3vrkgzz2jpz8mjq0uhgnmklnap6z33qqeszq2yn4"
    "erd1kyaqzaprcdnv4luvanah0gfxzzsnpaygsy6pytrexll2urtd05ts9vegu7"
    "erd1r69gk66fmedhhcg24g2c5kn2f2a5k4kvpr6jfw67dn2lyydd8cfswy6ede"
    "erd13x29rvmp4qlgn4emgztd8jgvyzdj0p6vn37tqxas3v9mfhq4dy7shalqrx"
    "erd1fggp5ru0jhcjrp5rjqyqrnvhr3sz3v2e0fm3ktknvlg7mcyan54qzccnan"
    "erd1kdl46yctawygtwg2k462307dmz2v55c605737dp3zkxh04sct7asqylhyv"
    "erd1z32fx8l6wk9tx4j555sxk28fm0clhr0cl88dpyam9zr7kw0hu7hsx2j524"
    "erd1uv40ahysflse896x4ktnh6ecx43u7cmy9wnxnvcyp7deg299a4sq6vaywa"
)
#!/bin/bash

# Arguments: royalties jsoncid imagecid tag1,tag2 => encoded in HEX
# https://www.online-toolz.com/tools/text-hex-convertor.php
# + add 0x before

# update me each time you have re-deployed
SC_ADDRESS="erd1qqqqqqqqqqqqqpgqf5kap4px390vm66j3huh54t3djq79acrjg9qyzgk4t"

OWNER_PEM="wallets/owner/owner.pem"
PROXY="https://devnet-gateway.elrond.com"
CHAIN="D"
PAYLOAD=""
wl() {
    for adress in "${ADRESSES[@]}"; do
        hex=$(erdpy wallet bech32 --decode $adress)
        PAYLOAD+=$hex
    done
    echo $PAYLOAD
    erdpy --verbose contract call ${SC_ADDRESS} \
        --recall-nonce \
        --pem=${OWNER_PEM} \
        --gas-limit=60000000 \
        --function whiteListMany@${PAYLOAD} \
        --send \
        --proxy=${PROXY} \
        --chain=${CHAIN}
}

# Run
# ---
wl
