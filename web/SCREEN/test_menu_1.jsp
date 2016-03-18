       
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <script src="../JS/jquery/jquery-2.1.4.js"></script>


        <style>
            html {
                overflow-y: scroll;
            }
            body {
                font: normal normal 90% sans-serif;
                max-width: 200px;
                margin: 100px auto 50px auto;
                background: #1f1f1f;
                text-align: center;
            }

            ul {
                list-style: none;
                margin: 0; padding: 0;
                text-align: left;
            }
            body > ul {
                margin-bottom: 300px;
                border: 1px solid #222;
                //@include box-shadow(0 0 25px #000);
            }
            body > ul > li {
                position: relative;
            }
            body > ul > li > a {
                display: block;
                outline: 0;
                padding: .7em 1em;
                text-decoration: none;
                color: #fff;
                font-weight: bold;
                //@include text-shadow(#111 0 -1px);
                background: #333;
                //@include box-shadow(inset 0 1px 0 0 rgba(250,250,250,0.1));
                //@include background-image(linear-gradient(#444, #333));
                //@include filter-gradient(#444, #333, horizontal);
                border-bottom: 1px solid #222;
            }
            body > ul > li > ul {
                counter-reset: items;
                height: 0;
                overflow: hidden;
                background: #eee;
                color: #777;
                font-size: .75em;
                //@include box-shadow(inset 0 0 50px #BBB);
            }
            body > ul > li > ul > li {
                counter-increment: items;
                padding: .5em 1.3em;
                border-bottom: 1px dotted #DDD;
            }
            body > ul > li > ul:after {
                content: counter(items);
                font-size: 0.857em;
                //@include inline-block;
                position: absolute;
                right: 10px;
                top: 15px;
                background: #333;
                line-height: 1em;
                height: 1em;
                padding: .7em .8em;
                margin: -.8em 0 0 0;
                color: white;
                text-indent: 0;
                text-align: center;
                //@include text-shadow(0px 1px 0px rgba(0, 0, 0, .5));
                font-weight: 500;
                //@include border-radius(.769em);
                //@include box-shadow(inset 0px 1px 3px 0px rgba(0, 0, 0, .26), 0px 1px 0px 0px rgba(255, 255, 255, .15));
            }
        </style>

        <script>
            $(function() {

                $("a").click(function() {
                    var ul = $(this).next(),
                            clone = ul.clone().css({"height": "auto"}).appendTo("body"),
                            height = ul.css("height") === "0px" ? ul[0].scrollHeight + "px" : "0px";

                    clone.remove();
                    ul.animate({"height": height});
                    return false;
                });

            });
        </script>

    </head>
    <ul>
        <li>
            <a href="#">Movies</a>
            <ul>
                <li>The Departed</li>
                <li>Sherlock Holmes</li>
                <li>Sin City</li>
                <li>Jarhead</li>
                <li>Jurassic Park</li>
                <li>Machete</li>
            </ul>
        </li>
        <li>
            <a href="#">TV shows</a>
            <ul>
                <li>Dexter</li>
                <li>Mad Men</li>
                <li>Breaking Bad</li>
                <li>Fringe</li>
                <li>Game of Thrones</li>
                <li>Californication</li>
                <li>Homeland</li>
                <li>Boardwalk Empire</li>
            </ul>
        </li>
        <li>
            <a href="#">Music</a>
            <ul>
                <li>B.B. King</li>
                <li>Howlin' Wolf</li>
                <li>Aretha Franklin</li>
                <li>John Lee Hooker</li>
                <li>Tom Waits</li>
                <li>Jimi Hendrix</li>
                <li>Muddy Waters</li>
                <li>James Brown</li>
                <li>Chuck Berry</li>
            </ul>
        </li>
        <li>
            <a href="#">Games</a>
            <ul>
                <li>Grand Theft Auto</li>
                <li>Half-Life</li>
                <li>Super Mario Galaxy</li>
                <li>Resident Evil</li>
            </ul>
        </li>
    </ul>
</html>

