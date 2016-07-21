$(function () {
    $('.toctree-wrapper').jstree();
    $('.toctree-wrapper').on("changed.jstree", function (e, data) {
        console.log(data.selected);
    });
    $('button').on('click', function () {
        $('.toctree-wrapper').jstree(true).select_node('child_node_1');
        $('.toctree-wrapper').jstree('select_node', 'child_node_1');
        $.jstree.reference('.toctree-wrapper').select_node('child_node_1');
    });
    $('.toctree-wrapper').bind("select_node.jstree", function (e, data) {
        $('.toctree-wrapper').jstree('save_state');
    }) ;
    $('.toctree-wrapper').on("activate_node.jstree", function(e,data){
       window.location.href = data.node.a_attr.href;
    })
});
function collapse_dd(){
        if ($(this).hasClass('collapsed')) {
            $(this).removeClass('collapsed')
            $(this).children('dd').show('fast')
        } else {
            $(this).addClass('collapsed')
            $(this).children('dd').hide('fast')
        }
        return false;
    }
$(document).ready(function() {
    $('dl.class > dd').hide()
    $('dl.class').addClass('collapsed').click(collapse_dd)
    $('dl.method > dd').hide()
    $('dl.method').addClass('collapsed').click(collapse_dd)
    $('dl.exception > dd').hide()
    $('dl.exception').addClass('collapsed').click(collapse_dd)
    $('div.section > dl.function > dd').hide()
    $('div.section > dl.function').addClass('collapsed').click(collapse_dd)

    $('a').click(function(e) {
        e.stopPropagation();
    })

    if (window.location.hash.length != 0) {
        base = window.location.hash.replace(/\./g, '\\.');
        base = $(base);
        base.removeClass('collapsed');
        base.parents('dd').show();
        base.parents('dl').removeClass('collapsed');
        base.siblings('dd').show();
    }
});
