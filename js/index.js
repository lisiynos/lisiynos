$(document).ready(function () {
    var total = [0, 0, 0, 0, 0, 0];
    var table = $('table#plan');

    table.find('tr:not(:first,.chapter)').each(function () {
        var $tr = $(this);
        var sum = 0;
        $tr.find('td.hours').each(function () {
            var $td = $(this);
            var col = $td.index();
            var value = sum;
            if (col == 3 || col == 6) {
                if (value > 0)
                    $td.html(value); // Записываем сумму
                else
                    $td.html('&nbsp;');
                sum = 0; // Обнуляем сумму
            } else {
                value = parseInt($td.html(), 10);
                if (isNaN(value)) value = 0;
                sum += value;
            }
            total[col - 1] += value;
        });
    });

    table.find('tr:last td.hours').each(function () {
        var $td = $(this);
        var col = $td.index();
        $td.html(total[col - 1]);
    });
});
