module Handler.Home where

import Import
getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Yesod Web Service Homepage"

    [whamlet|
        <div .container-fluid>
          <div .row-fluid>
            <h1>Hello

          <div .row-fluid>
            <div .span6>
                <h2>Fibs
                <p>
                    Fib number
                    <input #fibinput type=number value=4>
                    is
                    <span #fiboutput>

            <div .span6>

                <h2>Markdown
                <textarea #markdowninput>
                    ## Welcome

                    Welcome to the Markdown demo. __Markup__ should work *correctly*.
                <div .control-group>
                    <button #updatemarkdown .btn .btn-primary>Update markdown output
                <div #markdownoutput>
    |]

    -- Similar to Hamlet, Yesod has Lucius for CSS, and Julius for Javascript.
    toWidget [lucius|
        body {
            margin: 0 auto;
        }

        #markdowninput {
            width: 100%;
            height: 300px;
        }

        #markdownoutput {
            border: 1px dashed #090;
            padding: 0.5em;
            background: #cfc;
        }
    |]
    toWidget [julius|
        function updateFib() {
            $.getJSON("/fib/" + $("#fibinput").val(), function (o) {
                $("#fiboutput").text(o.value);
            });
        }

        function updateMarkdown() {
            // Note the use of the MarkdownR Haskell data type here.
            // This is an example of a type-safe URL.
            $.ajax("@{MarkdownR}", {
                data: {"markdown": $("#markdowninput").val()},
                success: function (o) {
                     $("#markdownoutput").html(o.html);
                },
                type: "PUT"
            });
        }

        $(function(){
            updateFib();
            $("#fibinput").change(updateFib);

            updateMarkdown();
            $("#updatemarkdown").click(updateMarkdown);
        });
    |]
    toWidgetIfJasmine [julius|
        describe("A suite", function() {
          it("contains spec with an expectation", function() {
            expect(true).toBe(true);
          });
        });
    |]