  $(document).ready(function() {

    function fadeToggle() {
      $("#instructions").toggle(1000);
    }

    $('#normal_dt').DataTable({
      scrollY: "30vh",
      scrollCollapse: true,
      paging: false,
      autoWidth: true,
      responsive: true,
      retrieve: true,
      stateSave: true,
      dom: 'Bfrtip',
      buttons: [
        {
        extend: 'print',
        }
      ]
    });

    $('#normal_dt2').DataTable({
      ordering: false,
      scrollY: "30vh",
      scrollCollapse: true,
      paging: false,
      autoWidth: true,
      responsive: true,
      retrieve: true,
      searching: false,
      info: false,
      dom: 'Bfrtip',
      buttons: [
        {
        extend: 'print',
        }
      ]
    });

    $('#order_dt').DataTable({
      scrollY: "30vh",
      scrollCollapse: true,
      paging: false,
      autoWidth: true,
      responsive: true,
      retrieve: true,
      searching: false,
      info: false,
      dom: 'Bfrtip',
      buttons: [
        {
        extend: 'print',
        }
      ]
    });

    $("#btnPrint").printPreview({
      obj2print:'#main'
    });

  });
