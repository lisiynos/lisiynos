function createRequestObject() {
    if (typeof XMLHttpRequest === 'undefined') {
        XMLHttpRequest = function () {
            try {
                return new ActiveXObject("Msxml2.XMLHTTP.6.0");
            }
            catch (e) {
            }
            try {
                return new ActiveXObject("Msxml2.XMLHTTP.3.0");
            }
            catch (e) {
            }
            try {
                return new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e) {
            }
            try {
                return new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e) {
            }
            throw new Error("This browser does not support XMLHttpRequest.");
        };
    }
    return new XMLHttpRequest();
}

function loadFile(node_id, filename, callback) {
    var a = createRequestObject();
    a.open("GET", filename, true);
    a.onreadystatechange = function () {
        try { // Важно!
            // только при состоянии "complete"
            if (a.readyState == 4) {
                // для статуса "OK"
                if (a.status == 200) {
                    // обработка ответа
                    document.getElementById(node_id).appendChild(document.createTextNode(a.responseText));
                    callback();
                } else {
                    alert("Не удалось получить данные:\n" +
                            a.statusText);
                }
            }
        }
        catch (e) {
            // alert('Ошибка: ' + e.description);
            // В связи с багом XMLHttpRequest в Firefox приходится отлавливать ошибку
            // Bugzilla Bug 238559 XMLHttpRequest needs a way to report networking errors
            // https://bugzilla.mozilla.org/show_bug.cgi?id=238559
        }
    }
    a.send(null);
}

function loadFiles(list, callback) {
    var count = 0;
    for (file in list) {
        loadFile(list[file][0], list[file][1], function () {
            count++;
            if (count == list.length) {
                callback();
            }
        });
    }
}