<!DOCTYPE html>
<html>
    <head>
        <title>Hello React!</title>
        <script src="../JS/react/react.js"></script>
        <script src="../JS/react/JSXTransformer.js"></script>
    </head>
    <body>
        <div id="example"></div>
        <script type="text/jsx">
          React.render(
            <h1>Hello, world!</h1>,
            document.getElementById('example')
          );
        </script>

        <script type="text/jsx">
	
    var Menu = React.createClass({
        render: function() {
            return (
                <ul>
                    <li>Menu 1</li>
                    <li>Menu 2</li>
                    <li>Menu 3</li>
                </ul>
            );
        }
    });
 
    var Search = React.createClass({
        render: function() {
            return (
                <form>
                    <input type="text" value="Search" />
                    <input type="submit" value="Submit" />
                </form>
            );
        }
    });
 
    var Header = React.createClass({
        render: function() {
            return (
                <header>
                    <Menu />
                    <Search />
                </header>
            );
        }
    });
 
    React.render(<Header />, document.getElementById('content'));
        </script>

    </body>
</html>