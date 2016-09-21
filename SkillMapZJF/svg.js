    /*  Constants: */ 
    var svgViewBoxWidth  = 4400;//viewbox 的宽 
    var svgViewBoxHeight = 3300;//viewbox 的高
    var leftArrow        = 37;	//上下左右4个键盘对应key
    var upArrow          = 38;
    var rightArrow       = 39;
    var downArrow        = 40;
    var panRate          = 200;// 上下左右移动像素    
    var zoomRate         = 1.1;// 放大缩小倍率
    var rate = 0.1;
    var num = 1;
    /* Globals: */
    var theSvgElement;
    //上下左右按钮  移动
    function processKeyPress(evt)
    {
      var viewBox = theSvgElement.getAttribute('viewBox');
      var viewBoxValues = viewBox.split(' ');

      viewBoxValues[0] = parseFloat(viewBoxValues[0]);
      viewBoxValues[1] = parseFloat(viewBoxValues[1]);
      
      switch (evt.keyCode)
      {
        case leftArrow:
          viewBoxValues[0] += panRate;
          break;
        case rightArrow:
          viewBoxValues[0] -= panRate;
          break;
        case upArrow:
          viewBoxValues[1] += panRate;
          break;
        case downArrow:
          viewBoxValues[1] -= panRate;      
          break;                         
      } // switch
      theSvgElement.setAttribute('viewBox', viewBoxValues.join(' '));
    }
    //放大缩小  viewbox 乘以/除以   倍率    
    function zoom(zoomType)
    {
      var viewBox = theSvgElement.getAttribute('viewBox');
      var viewBoxValues = viewBox.split(' ');	
      
      viewBoxValues[2] = parseFloat(viewBoxValues[2]);
      viewBoxValues[3] = parseFloat(viewBoxValues[3]);
      if (zoomType == 'zoomIn')//fangda 
      {num += rate;
        //viewBoxValues[2] /= zoomRate;
        //viewBoxValues[3] /= zoomRate;	
      }
      else if (zoomType == 'zoomOut')
      {num -= rate;
       // viewBoxValues[2] *= zoomRate;
       // viewBoxValues[3] *= zoomRate;	
      }
      else
        alert("方法传参错误");
       var x = (parseFloat(viewBoxValues[2]) + parseFloat(viewBoxValues[0]))/2;
       var y = (parseFloat(viewBoxValues[3]) + parseFloat(viewBoxValues[1]))/2;
       var a = -((parseFloat(viewBoxValues[2]) + parseFloat(viewBoxValues[0]))/2);
       var b = -((parseFloat(viewBoxValues[3]) + parseFloat(viewBoxValues[1]))/2);
      //theSvgElement.setAttribute('viewBox', viewBoxValues.join(' '));  ,"+x+" "+y+"
      $("g:first").attr("transform","translate("+x+" "+y+") scale("+num+" "+num+") translate("+a+" "+b+")");
      //显示倍率
      var currentZoomFactor = svgViewBoxWidth / viewBoxValues[2];  
      if(currentZoomFactor<=1.5){
      	$("text[type='station']").hide();
      }else{
      	$("text[type='station']").show();
      }   
      var newText = document.createTextNode(currentZoomFactor.toFixed(3));
      var parentNode = document.getElementById('currentZoomFactorText');
      
      parentNode.replaceChild(newText, parentNode.firstChild);
    }
    //  鼠标滚动事件       
    function zoomViaMouseWheel(mouseWheelEvent)
    {      
    	if (mouseWheelEvent.wheelDelta) {
                if (mouseWheelEvent.wheelDelta > 0)
			        zoom('zoomIn');
			      else
			        zoom('zoomOut');
        } else if (mouseWheelEvent.detail) {  //ff的事件不同，而且向下向上滚动的值不同
                if (mouseWheelEvent.detail > 0)
			        zoom('zoomOut');
			      else
			        zoom('zoomIn');
        }
      
        
      //阻止冒泡事件  ff和chrome都能用
      mouseWheelEvent.stopPropagation();	
      return false;							
    }
    
    var initialize = function ()
    {        
      //绑定上下左右按钮
      window.addEventListener('keydown', processKeyPress, true);		// OK to let the keydown event bubble.
      // 浏览器的鼠标滚轮滚动事件差异
      if ($.browser.mozilla) {
	      window.addEventListener('DOMMouseScroll', zoomViaMouseWheel, false);
	  }else{
	  	  window.addEventListener('mousewheel', zoomViaMouseWheel, false);	
	  }
      // 上面定义了全局变量，根据id赋值
      theSvgElement = document.getElementById('svgElement');
      //检查你的页面支不支持SVG功能
      if(theSvgElement.namespaceURI != "http://www.w3.org/2000/svg")	
        alert("Inline SVG in HTML5 is not supported. This document requires a browser that supports HTML5 inline SVG.");
            
      //为svg的viewbox设定初始值
      theSvgElement.setAttribute('viewBox', "0 0 " + svgViewBoxWidth + " " + svgViewBoxHeight);	
    }
    $(function() { 
    	var startx,starty,endx,endy,movex,movey;
    	//鼠标按下去的事件
    	$("#svgElement").mousedown(function(e){ 
    		 var theEvent = window.event || e;
		     startx = theEvent.clientX;
		     starty = theEvent.clientY;
		});
		//鼠标抬起来的事件
		$("#svgElement").mouseup(function(e){
			 var theEvent = window.event || e; 
		     endx = theEvent.clientX;
		     endy = theEvent.clientY;
		     movex = endx - startx;
		     movey = endy - starty;
		     moveSVG(movex,movey);
		});
    	
    });  
    //根据偏移量移动svg的方法
    var moveSVG = function (movex,movey){
    	//svg平移是修改viewbox的x，y前两个  1获取原来大小，2根据空格split 3.获取数组0、1 4.修改变量重新赋值
		var viewBox = theSvgElement.getAttribute('viewBox');
		var viewBoxValues = viewBox.split(' ');
		viewBoxValues[0] = parseFloat(viewBoxValues[0]);
		viewBoxValues[1] = parseFloat(viewBoxValues[1]);
		viewBoxValues[0] -= movex;
		viewBoxValues[1] -= movey;
		theSvgElement.setAttribute('viewBox', viewBoxValues.join(' '));
    }
    
	//画路径
	var drawLine = function (color,weight,stations){
		var d = "";
		for(var i=0;i<stations.length;i++){
			if(i==0){
				d += "M"+stations[i].x+" "+stations[i].y+" ";
			}else if(stations[i].type=="control"){
			 	d += "Q"+stations[i].x+" "+stations[i].y+" "+stations[i+1].x+" "+stations[i+1].y+" ";
			 	i++;
			}else{
				d += "L"+stations[i].x+" "+stations[i].y+" ";
			}
			
		} 
		var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
		//path = $("<path id=\"line1\" d='"+d+"' stroke=\"red\"  stroke-width=\"20\" fill=\"none\" />");
		path.setAttribute('d', d);
		path.setAttribute('stroke', color);
		path.setAttribute('stroke-width', weight);
		path.setAttribute('fill', 'none');
		//效果等与上面
		/* var text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
		var inText = $(text).attr({
		        id: business_arr[bu]['id'],
		        x: business_arr[bu]['xLable'],
		        y: business_arr[bu]['yLable']
        });
		$(text).text(business_arr[bu]['name']);
		$('#map').append(inText); */
		document.getElementById("a").appendChild(path);
	};
	//画点 
	var drawPoint = function (s){
		for(var i=0;i<s.length;i++){
			if(s[i].type=="station"){
				var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
				circle.setAttribute('cx', s[i].x);
				circle.setAttribute('cy', s[i].y);
				circle.setAttribute('type', 'station');
				circle.setAttribute('r', 15);
				var color;
				if(typeof(s[i].color) != "undefined"){
					color = s[i].color;
				}else{
					color = 'green';
				}
				circle.setAttribute('stroke', color);
				circle.setAttribute('stroke-width', 5);
				circle.setAttribute('fill', 'white');
				document.getElementById("a").appendChild(circle);
			}else if(s[i].type=="transfer"){
				var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
				/* <circle cx="1544" cy="1578" r="15" stroke="black" stroke-width="5" fill="white" /> */
				circle.setAttribute('cx', s[i].x);
				circle.setAttribute('cy', s[i].y);
				circle.setAttribute('type', 'transfer');
				circle.setAttribute('r', 25);
				if(typeof(s[i].color) != "undefined"){
					color = s[i].color;
				}else{
					color = 'green';
				}
				circle.setAttribute('stroke', color);
				circle.setAttribute('stroke-width', 5);
				circle.setAttribute('fill', 'white');
				document.getElementById("a").appendChild(circle);
				//半程站
				//var d = createTransferHalfArrow(parseInt(s[i].x)+(25 * 0.06 - 25),parseInt(s[i].y)+(25 * 0.06 - 25),25*0.8);
				// 普通换乘上半圆
				var top = createTransferArrow(parseInt(s[i].x)+(25 * 0.08 - 25),parseInt(s[i].y)+(25 * 0.08 - 25),25*0.92);
				var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
				path.setAttribute('d', top);
				path.setAttribute('stroke', s[i].color);
				path.setAttribute('stroke-width', 3);
				path.setAttribute('fill', s[i].color);
				document.getElementById("a").appendChild(path);
				
				// 普通换乘下半圆
				var bot = createTransferArrow(parseInt(s[i].x)+(25 * 0.95 *2 - 25),parseInt(s[i].y)+(25 * 0.96 *2 - 25),25*0.92);
				
				var botpath = document.createElementNS("http://www.w3.org/2000/svg", "path");
				botpath.setAttribute('d', bot);
				botpath.setAttribute('stroke', s[i].color2);
				botpath.setAttribute('stroke-width', 3);
				botpath.setAttribute('fill', s[i].color2);
				//翻转180度  上面x，y为中心点
				var x = parseInt(s[i].x)+(25 * 0.95 *2 - 25);
				var y = parseInt(s[i].y)+(25 * 0.96 *2 - 25);
				botpath.setAttribute('transform', 'rotate(180 '+x+' '+y+')');
				document.getElementById("a").appendChild(botpath);
			}else if(s[i].type=="transfer3"){
				var circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
				/* <circle cx="1544" cy="1578" r="15" stroke="black" stroke-width="5" fill="white" /> */
				circle.setAttribute('cx', s[i].x);
				circle.setAttribute('cy', s[i].y);
				circle.setAttribute('r', 25);
				circle.setAttribute('type', 'transfer');
				if(typeof(s[i].color) != "undefined"){
					color = s[i].color;
				}else{
					color = 'green';
				}
				circle.setAttribute('stroke', color);
				circle.setAttribute('stroke-width', 5);
				circle.setAttribute('fill', 'white');
				document.getElementById("a").appendChild(circle);
			
				//三个换乘点
				var d1 = createTransfer3Arrow(parseInt(s[i].x)+(25 * 0.0 - 25),parseInt(s[i].y)+(25 * 0.0 - 25),25*0.9);
				var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
				path.setAttribute('d', d1);
				path.setAttribute('stroke', s[i].color);
				path.setAttribute('stroke-width', 3);
				path.setAttribute('fill', s[i].color);
				document.getElementById("a").appendChild(path);
				
				var d2 = createTransfer3Arrow(parseInt(s[i].x)+(25 * 1.18 * 2 - 25),parseInt(s[i].y)+(25 * 0.65 - 25),25*0.9);
				var path2 = document.createElementNS("http://www.w3.org/2000/svg", "path");
				path2.setAttribute('d', d2);
				path2.setAttribute('stroke', s[i].color2);
				path2.setAttribute('stroke-width', 3);
				path2.setAttribute('fill', s[i].color);
				//翻转120度  上面x，y为中心点
				var x = parseInt(s[i].x)+(25 * 1.18 * 2 - 25);
				var y = parseInt(s[i].y)+(25 * 0.65 - 25);
				path2.setAttribute('transform', 'rotate(120 '+x+' '+y+')');
				document.getElementById("a").appendChild(path2);
				
				var d3 = createTransfer3Arrow(parseInt(s[i].x)+(25 * 0.65 - 25),parseInt(s[i].y)+(25 * 1.18 * 2 - 25),25*0.9);
			
				var path3 = document.createElementNS("http://www.w3.org/2000/svg", "path");
				path3.setAttribute('d', d3);
				path3.setAttribute('stroke', s[i].color3);
				path3.setAttribute('stroke-width', 3);
				path3.setAttribute('fill', s[i].color);
				//翻转240度  上面x，y为中心点
				var x = parseInt(s[i].x)+(25 * 0.65 - 25);
				var y = parseInt(s[i].y)+(25 * 1.18 * 2 - 25);
				path3.setAttribute('transform', 'rotate(240 '+x+' '+y+')');
				document.getElementById("a").appendChild(path3);
			}
		
		}
	};
	//画点 
	var drawText = function (s){
		for(var i=0;i<s.length;i++){
		    /* <text x="180" y="1935" style="text-anchor: middle;">古城</text> */
			var x = parseInt(s[i].x);
			var y = parseInt(s[i].y);
			var text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
			$(text).text(s[i].label.text);
			var currentFont = "normal 13px Helvetica, Arial, sans-serif";
			var length = GetCurrentStrWidth(s[i].label.text,currentFont);
			//alert(length);
			
			//alert($(text).attr('height'));
			if(typeof(s[i].label.top) != "undefined"){
				y -= 30;
			}
			if(typeof(s[i].label.bottom) != "undefined"){
				y += 40;
			}
			if(typeof(s[i].label.left) != "undefined"){
				x =x-length-20;
			}
			if(typeof(s[i].label.right) != "undefined"){
				x =x+ length+20;
			}
			
			text.setAttribute('x', x);
			text.setAttribute('y', y);
			text.setAttribute('type', s[i].type);
			text.setAttribute('text-anchor', 'middle');
			$("#a").append(text);
			
		}
	};
	
	//图标 
	var drawImage = function (img){
		for(var i=0;i<img.length;i++){
			var image = document.createElementNS('http://www.w3.org/2000/svg', 'image');
			image.setAttributeNS(null,'height','200');
            image.setAttributeNS(null,'width','200');
			image.setAttributeNS('http://www.w3.org/1999/xlink','href', img[i].src);
			image.setAttributeNS(null,'x',img[i].x);
			image.setAttributeNS(null,'y',img[i].y);
			$("#a").append(image);
		}
	};
	//图标 
	var drawLineText = function (linename){
		for(var i=0;i<linename.length;i++){
			var text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
			text.setAttribute('x', linename[i].x);
			text.setAttribute('y', linename[i].y);
			text.setAttribute('fill', linename[i].color);
			text.setAttribute('text-anchor', 'middle');
			$(text).text(linename[i].text);
			$("#a").append(text);
		}
	};
	// 创建半程车换乘站的箭头图标
	var createTransferHalfArrow = function (x,y,r){
	    var d = "M"+(x+r * 2 * 0.15)+" "+(y+r * 2 * 0.53)+" Q "+(x+r * 2 * 0.15)+" "+(y+r * 2 * 0.43)+" "+(x+r * 2 * 0.19)+" "+(y+r * 2 * 0.35);
	    d += " Q "+(x+r * 2 * 0.23)+" "+(y+r * 2 * 0.26)+" "+(x+r * 2 * 0.30)+" "+(y+r * 2 * 0.21);
	    d += " L "+(x+r * 2 * 0.24)+" "+(y+r * 2 * 0.16);
	    d += " Q "+(x+r * 2 * 0.34)+" "+(y+r * 2 * 0.16)+" "+(x+r * 2 * 0.40)+" "+(y+r * 2 * 0.16);
	    d += " Q "+(x+r * 2 * 0.47)+" "+(y+r * 2 * 0.17)+" "+(x+r * 2 * 0.53)+" "+(y+r * 2 * 0.18);
	    d += " Q "+(x+r * 2 * 0.17)+" "+(y+r * 2 * 0.18)+" "+(x+r * 2 * 0.15)+" "+(y+r * 2 * 0.53) +" Z ";
	    return d; 
	};
	//创建换乘站的箭头图标
	var createTransferArrow = function (x,y,r){
		var d = "M"+(x+r * 2 * 0.12)+" "+(y+r * 2 * 0.58);
		d +=" Q "+(x+r * 2 * 0.10)+" "+(y+r * 2 * 0.25)+" "+(x+r * 2 * 0.39)+" "+(y+r * 2 * 0.14);
		d +=" Q "+(x+r * 2 * 0.47)+" "+(y+r * 2 * 0.11)+" "+(x+r * 2 * 0.56)+" "+(y+r * 2 * 0.12);
		d +=" Q "+(x+r * 2 * 0.66)+" "+(y+r * 2 * 0.14)+" "+(x+r * 2 * 0.74)+" "+(y+r * 2 * 0.21);
		d +=" Q "+(x+r * 2 * 0.79)+" "+(y+r * 2 * 0.25)+" "+(x+r * 2 * 0.84)+" "+(y+r * 2 * 0.33);
		d += " L "+(x+r * 2 * 0.49)+" "+(y+r * 2 * 0.44);
		d += " Q "+(x+r * 2 * 0.64)+" "+(y+r * 2 * 0.24)+" "+(x+r * 2 * 0.44)+" "+(y+r * 2 * 0.26);
	    d += " Q "+(x+r * 2 * 0.16)+" "+(y+r * 2 * 0.31)+" "+(x+r * 2 * 0.12)+" "+(y+r * 2 * 0.58) +" Z ";
		return d;
	};
	//创建三站换乘站的箭头图标
	var createTransfer3Arrow = function (x,y,r){
		var d = "M"+(x+r * 2 * 0.29)+" "+(y+r * 2 * 0.50);
		d +=" Q "+(x+r * 2 * 0.14)+" "+(y+r * 2 * 0.29)+" "+(x+r * 2 * 0.36)+" "+(y+r * 2 * 0.19);
		d +=" Q "+(x+r * 2 * 0.58)+" "+(y+r * 2 * 0.09)+" "+(x+r * 2 * 0.76)+" "+(y+r * 2 * 0.27);
		d += " L "+(x+r * 2 * 0.43)+" "+(y+r * 2 * 0.37);
		d +=" Q "+(x+r * 2 * 0.48)+" "+(y+r * 2 * 0.33)+" "+(x+r * 2 * 0.49)+" "+(y+r * 2 * 0.30);
		d +=" Q "+(x+r * 2 * 0.50)+" "+(y+r * 2 * 0.25)+" "+(x+r * 2 * 0.42)+" "+(y+r * 2 * 0.25);
		d +=" Q "+(x+r * 2 * 0.37)+" "+(y+r * 2 * 0.25)+" "+(x+r * 2 * 0.35)+" "+(y+r * 2 * 0.27);
		d +=" Q "+(x+r * 2 * 0.26)+" "+(y+r * 2 * 0.34)+" "+(x+r * 2 * 0.29)+" "+(y+r * 2 * 0.50);
		return d;	
	};
	var GetCurrentStrWidth = function (text,font) {
        var currentObj = $('<pre>').hide().appendTo(document.body);
        $(currentObj).html(text).css('font', font);
        var width = currentObj.width();
        currentObj.remove();
        return width;
    };	
    
    var addpath = function (){
    	var stations = [];
    	var dataroot="response.json"; 
		$.getJSON(dataroot, function(data){
			for(var i=0;i<data.data[1].segments.length;i++){
				//线名
				var linecode = data.data[1].segments[i].lcode;
				var sdata =data.data[1].segments[i].sdata;
				var path = querypath(linecode,sdata);
				for(var j=0;j<path.length;j++){
					stations.push(path[j]);
				}
			}
			drawLine('black',10,stations);
			drawPoint(stations);
		});
    };	

    var querypath = function(linecode,sdata){
    	for(var i =0;i<subWaydata.lines.line.length;i++){
    		if(subWaydata.lines.line[i].code==linecode){
    			var lfcode,lscode,lecode;
    			for(var j=0;j<subWaydata.lines.line[i].s.length;j++){
    				if(subWaydata.lines.line[i].s[j].code == sdata[0].scode){
    					lfcode = j;
    				}
    				if(subWaydata.lines.line[i].s[j].code == sdata[1].scode){
    					lscode = j;
    				}
    				if(subWaydata.lines.line[i].s[j].code == sdata[sdata.length-1].scode){
    					lecode = j;
    				}
    			}
    			if(lscode-lfcode>0){
    				return subWaydata.lines.line[i].s.slice(lfcode,lecode+1);
    			}else{
    			    return subWaydata.lines.line[i].s.slice(lecode,lfcode+1).reverse();
    			}
    		}
    	}
    };	
