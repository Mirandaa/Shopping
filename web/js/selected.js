window.onload=function(){
    var oBtn=document.getElementById('orderBy');

    var lis = document.querySelectorAll("ul");

    for(var i = 0; i < lis.length; i++)
    {
        lis[i].onclick = function ()
        {
            lis.t ? lis.t.style.color = "black" : 0;
            lis.t ? lis.t.style.background = "white" : 0;

            this.style.color = "#0F88EB";
            this.style.background = "#EEEEEE";

            lis.t = this;
        }
    }
}