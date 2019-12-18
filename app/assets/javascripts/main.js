$(function () {
    let form = $('#movie-search');
    form.submit(function (e) {
        e.preventDefault();
        $.ajax({
                url: 'https://api.themoviedb.org/3/search/movie?api_key=12ce4e2bef2c5b2385bff21967591bd8',
                data: form.serialize()
            })
            .done(function (data) {
                displayMoives(data);
            });
    });

    function displayMoives(data) {
        let container = $("#movies")
        let htmlString = "";

        container.empty();
        let imageUrl = getBaseImageUrl();

        if (data["results"].length == 0) {
            htmlString = `<div class="alert alert-danger text-center>" role="alert">No Data Found!</div>`;
        } else {
            data["results"].forEach(function (movie) {
                htmlString += `<img src=${movie["poster_path"] == null ? "/assets/Image_Available.jpg" : imageUrl + "/" + movie["poster_path"]} />
                <p>${movie["title"]}</p>
                <p>${movie["overview"]}</p>`;
            });
        }

        container.append(htmlString);
    }
});

function getBaseImageUrl() {
    var url = "";
    var settings = {
        "async": false,
        "crossDomain": true,
        "url": "https://api.themoviedb.org/3/configuration?api_key=12ce4e2bef2c5b2385bff21967591bd8",
        "method": "GET",
        "header": {},
        "data": "{}"
    }
    $.ajax(settings).done(function (response) {
        url = response["images"]["base_url"] + response["images"]["poster_sizes"][3];
    });
    return url;
}