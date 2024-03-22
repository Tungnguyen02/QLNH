<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Food.User.Default" %>
<%@ Import Namespace="Food" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>three.js webgl - animation - keyframes</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
		<link type="text/css" rel="stylesheet" href="main.css">
		<style>
			body {
				background-color: #bfe3dd;
				color: #000;
			}

			a {
				color: #2983ff;
			}
		</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div id="container"></div>

		<script type="importmap">
			{
				"imports": {
					"three": "./build/three.module.js",
					"three/addons/": "./jsm/"
				}
			}
		</script>

		<script type="module">

			import * as THREE from 'three';

			import Stats from 'three/addons/libs/stats.module.js';

			import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
			import { RoomEnvironment } from 'three/addons/environments/RoomEnvironment.js';

			import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
			import { DRACOLoader } from 'three/addons/loaders/DRACOLoader.js';

			let mixer;

			const clock = new THREE.Clock();
			const container = document.getElementById( 'container' );

			const stats = new Stats();
			container.appendChild( stats.dom );

			const renderer = new THREE.WebGLRenderer( { antialias: true } );
			renderer.setPixelRatio( window.devicePixelRatio );
			renderer.setSize( window.innerWidth, window.innerHeight );
			container.appendChild( renderer.domElement );

			const pmremGenerator = new THREE.PMREMGenerator( renderer );

			const scene = new THREE.Scene();
			scene.background = new THREE.Color( 0xbfe3dd );
			scene.environment = pmremGenerator.fromScene( new RoomEnvironment( renderer ), 0.04 ).texture;

			const camera = new THREE.PerspectiveCamera( 40, window.innerWidth / window.innerHeight, 1, 100 );
			camera.position.set( 5, 2, 8 );

			const controls = new OrbitControls( camera, renderer.domElement );
			controls.target.set( 0, 0.5, 0 );
			controls.update();
			controls.enablePan = false;
			controls.enableDamping = true;

			const dracoLoader = new DRACOLoader();
			dracoLoader.setDecoderPath( 'jsm/libs/draco/gltf/' );

			const loader = new GLTFLoader();
			loader.setDRACOLoader( dracoLoader );
			loader.load( 'models/gltf/LittlestTokyo.glb', function ( gltf ) {

				const model = gltf.scene;
				model.position.set( 1, 1, 0 );
				model.scale.set( 0.01, 0.01, 0.01 );
				scene.add( model );

				mixer = new THREE.AnimationMixer( model );
				mixer.clipAction( gltf.animations[ 0 ] ).play();

				animate();

			}, undefined, function ( e ) {

				console.error( e );

			} );


			window.onresize = function () {

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

			};


			function animate() {

				requestAnimationFrame( animate );

				const delta = clock.getDelta();

				mixer.update( delta );

				controls.update();

				stats.update();

				renderer.render( scene, camera );

			}


        </script>
    <!-- offer section -->



    <section class="offer_section layout_padding-bottom">
        <div class="offer_container">
            <div class="container ">
                <div class="row">
                    <asp:Repeater ID="rCategory" runat="server">
                        <ItemTemplate>
                            <div class="col-md-6  ">
                                <div class="box ">
                                    <div class="img-box">
                                        <a href="Menu.aspx?id=<%# Eval("CategoryId") %>">
                                            <img src="<%# Food.Utils.GetImageUrl( Eval("ImageUrl")) %>" alt="">
                                        </a>
                                        
                                    </div>
                                    <div class="detail-box">
                                        <h5>
                                            <%# Eval("Name") %>
                                        </h5>
                                        <h6>
                                            <span>20%</span> Giảm Giá
                                        </h6>
                                        <a href="Menu.aspx?id=<%# Eval("CategoryId") %>"> Đặt Ngay
                   
                                            <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 456.029 456.029" style="enable-background: new 0 0 456.029 456.029;" xml:space="preserve">
                                                <g>
                                                    <g>
                                                        <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                     c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                                                    </g>
                                                </g>
                                                <g>
                                                    <g>
                                                        <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                     C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                     c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                     C457.728,97.71,450.56,86.958,439.296,84.91z" />
                                                    </g>
                                                </g>
                                                <g>
                                                    <g>
                                                        <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                     c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                                                    </g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                                <g>
                                                </g>
                                            </svg>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>


                </div>
            </div>
        </div>
    </section>

    <!-- end offer section -->

    <!-- about section -->

    <section class="about_section layout_padding-bottom layout_padding-top">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/about-img.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Bánh Mì</h2>
                        </div>
                        <p>
                            Bánh mì là một món ăn Việt Nam, với lớp vỏ ngoài là một ổ bánh mì nướng có da giòn, ruột mềm, còn bên trong là phần nhân. Tùy theo văn hóa vùng miền hoặc sở thích cá nhân, người ta có thể chọn nhiều nhân bánh mì khác nhau...
           
                        </p>

                        
                            <details>
                            <summary>Xem Thêm</summary>
                            <p>Tuy nhiên, loại nhân bánh truyền thống thường chứa chả lụa, thịt, cá, thực phẩm chay hoặc mứt trái cây, kèm theo một số nguyên liệu phụ khác như patê, bơ, rau, ớt và đồ chua. Bánh mì được xem như một loại thức ăn nhanh bình dân và thường được tiêu thụ trong bữa sáng hoặc bất kỳ bữa phụ nào trong ngày. Do có giá thành phù hợp nên bánh mì trở thành món ăn được rất nhiều người ưa chuộng.</p>
                            </details>
                                                 
                        <a href="Menu.aspx?id=13">Đặt Ngay</a>

                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Bún Bò Huế</h2>
                        </div>
                        <p>
                             Đây là món ăn phổ biến ở miền Trung. Một bát bún bò Huế gồm bún, thịt bò, nước dùng và “ngôi sao” của bát chính là... mắm tôm. Bún bò Huế ăn kèm một chút lá húng quế, hoa chuối và hành lá cắt nhỏ...
           
                        </p>
                          <details>
                            <summary>Xem Thêm</summary>
                            <p>Bún bò Huế xưa ra đời từ thời chúa Nguyễn Hoàng (khoảng thế kỷ thứ 16). Tương truyền, xưa có cô Bún xinh đẹp, giỏi giang, thạo nghề làm bún. Tại làng Vân Cù (nay thuộc thị xã Hương Trà, tỉnh Thừa Thiên Huế), cô Bún đã sáng tạo ra cách chế biến một món ăn mới: Lấy thịt bò nấu thành nước dùng cho món bún. Từ đó, món bún bò ra đời, được lưu giữ và phát triển qua nhiều thế hệ. Đến nay, bún bò Huế đã được cải biên với sự có mặt của nhiều nguyên liệu khác như giò heo, tiết lợn, chả cua,...</p>
                            </details>
                        <a href="Menu.aspx?id=14">Đặt Ngay</a>
                    </div>
                </div>
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/hutieu.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>



    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/banhxeo.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Bánh Xèo</h2>
                        </div>
                        <p>
                          Bánh xèo được đặt tên theo âm thanh phát ra khi tráng bánh. Bánh xèo gần giống bánh crepe của phương Tây, chỉ khác là phần nhân gồm thịt lợn, tôm và giá đỗ. Bánh được dùng với nước mắm. Đây là món đặc trưng gần như của cả miền Nam và miền Trung, mỗi miền sẽ có cách pha chế nước chấm và cách tráng bánh khác nhau...
           
                        </p>

                        
                            <details>
                            <summary>Xem Thêm</summary>
                            <p>Cái tên “bánh xèo” xuất phát từ âm thanh lúc đổ bánh. Khi người làm cho một giá bột vào chảo dầu nóng rực, tiếng xèo xèo vang lên và kéo dài cho đến khi bánh gần chín. Từ đó chiếc bánh truyền thống này có tên là bánh xèo.
                                Nhìn chung sẽ có hai loại bánh xèo thường thấy là bánh xèo miền Trung và bánh xèo miền Tây. Trong đó:

Bánh xèo miền Tây mỏng và lớn hơn các bánh xèo những vùng khác. Bánh xèo miền Tây có vỏ bánh màu vàng, thơm mùi nước cốt dừa béo béo. Nhân bánh bao gồm tôm thịt, đậu xanh, ở một số vùng còn có thêm nhân thịt vịt, củ hũ dừa.

Bánh xèo miền Tây thường ăn với các loại rau rừng như lá ổi, lá cóc, lá bằng lăng, diếp cá, lá xoài, tía tô,...Bánh xèo miền Tây được chấm với nước mắm tỏi ớt chua ngọt cực kỳ bắt vị và thơm ngon.</p>
                            </details>
                                                 
                        <a href="Menu.aspx?id=14">Đặt Ngay</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

   
     
      <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Bún Chả Cá</h2>
                        </div>
                        <p>
                             Người Hà Nội coi món chả cá đặc biệt đến nỗi có cả một con phố ở thủ đô dành riêng cho những miếng cá chiên này. Con hẻm cùng tên này là quê hương của Chả cá Lã Vọng, nơi phục vụ những miếng cá nóng hổi được nêm tỏi, gừng, nghệ và thì là trên chảo nóng hổi...
               
           
                        </p>      
                        <details>
                            <summary>Xem Thêm</summary>
                            <p>Chả cá Lã Vọng có thể là bận rộn nhất nhưng dịch vụ hơi cộc cằn và thức ăn quá đắt. Thay vào đó, hãy tìm đường đến Dương Thân ở quận Hoàn Kiếm của Hà Nội, nơi bạn sẽ tìm thấy nhiều lựa chọn hợp túi tiền nhưng không kém phần ngon miệng.</p>
                            </details>
                        <a href="Menu.aspx?id=14">Đặt Ngay</a>
                    </div>
                </div>
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/buncha.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>


    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/bunbohue.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Hủ Tiếu Nam Vang</h2>
                        </div>
                        <p>
                             Hủ tiếu Nam Vang là món ăn khá phổ biến ở Nam Bộ. Một tô hủ tiếu Nam Vang sẽ bao gồm rất nhiều nguyên liệu và phần nước lèo thơm ngon...
           
                        </p>

                        
                            <details>
                            <summary>Xem Thêm</summary>
                            <p>Hủ tiếu Nam Vang là một món ăn có có nguồn gốc từ Phnôm Pênh, Campuchia. Cộng đồng người Hoa ở Nam Vang (tên phiên âm Hán Việt của Phnôm Pênh) đã chế biến lại, sau đó đưa món ăn này về Việt Nam. Về sau, hủ tiếu Nam Vang được thêm nhiều loại gia vị đậm đà hơn để phù hợp với văn hóa ẩm thực của người Việt và trở thành đặc sản Sài Gòn, nổi tiếng ba miền..</p>
                            </details>
                                                 
                        <a href="Menu.aspx?id=14">Đặt Ngay</a>
                       
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Kem Dừa</h2>
                        </div>
                        <p>
                              
                            Kem dừa là một trong những loại kem đang chiếm được cảm tình của nhiều người, được chế biến cùng nướt cốt dừa, thay vì sữa bò như các loại kem thông thường khác...
               
           
                        </p>      
                        <details>
                            <summary>Xem Thêm</summary>
                            <p> Bên cạnh hương vị ngọt, mát, kem dừa còn có một vài khuyết điểm mà người thưởng thức cần chú ý khi dùng.</p>
                            </details>
                        <a href="Menu.aspx?id=18">Đặt Ngay</a>
                    </div>
                </div>
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/kemdua.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/sen.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Chè Hạt Sen</h2>
                        </div>
                        <p>
                             Chè hạt sen là một loại chè phổ biến ở Việt Nam cũng như các nước trong khu vực châu Á. Với chè sen nấu kiểu Huế, hạt sen, nhất là sen hồ Tịnh Tâm...
           
                        </p>

                        
                            <details>
                            <summary>Xem Thêm</summary>
                            <p>được hấp chín sau đó nấu chung với đường cát trắng hay đường phèn cho đến khi sôi nhẹ. Khi vị ngọt của đường thấm vào hạt sen là có thể tắt bếp.</p>
                            </details>
                                                 
                        <a href="Menu.aspx?id=19">Đặt Ngay</a>
                       
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Nước Cam Ép</h2>
                        </div>  
                        <p>
                              
                            Nước ép cam là một loại nước ép vô cùng phổ biến và được nhiều người yêu thích bởi sự chua ngọt, dễ uống cũng như hỗ trợ nguồn vitamin C...
               
           
                        </p>      
                        <details>
                            <summary>Xem Thêm</summary>
                            <p> giúp tăng sức đề kháng cho cơ thể. Hôm nay hãy cùng vào bếp với Điện máy XANH ngay để tham khảo ngay 4 công thức làm nước ép cam thanh mát này nhé.</p>
                            </details>
                        <a href="Menu.aspx?id=18">Đặt Ngay</a>
                    </div>
                </div>
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/camep.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="about_section layout_padding-bottom">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/trangmieng.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>Sương Sáo</h2>
                        </div>
                        <p>
                            Sương sáo không chỉ là thứ giải khát thông thường mà còn là một tân dược. Theo Đông y, lá sương sáo có vị ngọt, tính mát có tác dụng giải nhiệt, giúp các quá trình...
           
                        </p>

                        
                            <details>
                            <summary>Xem Thêm</summary>
                            <p> chuyển hóa trong cơ thể diễn ra dễ dàng… nên thường được sử dụng để nấu và chế biến thành món thạch sương sáo giải nhiệt trong những ngày hè oi bức, nóng nực..</p>
                            </details>
                                                 
                        <a href="Menu.aspx?id=19">Đặt Ngay</a>
                       
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- end about section -->
    <!-- client section -->

    <section class="client_section layout_padding-bottom pt-5">
        <div class="container">
            <div class="heading_container heading_center psudo_white_primary mb_45">
                <h2>Khách Hàng Của Chúng Tôi
        </h2>
            </div>
            <div class="carousel-wrap row ">
                <div class="owl-carousel client_owl-carousel">
                    <div class="item">
                        <div class="box">
                            <div class="detail-box">
                                <p>
                                   "Người Việt không nhận ra những món ăn với giá thành hết sức rẻ của họ có tiêu chuẩn ẩm thực cao đến thế nào.Hương vị rất lạ mà rất ngon và tuyệt vời!"
               
                                </p>
                                <h6>Gordon Ramsay, 06/06/2022</h6>
                               <%-- <p>
                                    magna aliqua
               
                                </p>--%>
                            </div>
                            <div class="img-box">
                                <img src="../TemplateFiles/images/anh1.png" alt="" class="box-img">
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="box">
                            <div class="detail-box">
                                <p>
                                    "Món dùng thực tế nhìn y hệt như các hình ảnh trong cuốn thực đơn! Hương vị thì vô cùng tuyệt vời.Giá cả phải chăng,Một trong những trải nghiệm ẩm thực tuyệt vời nhất mà tôi từng có."
               
                                </p>
                                <h6>Chirag Patel, 12/03/2023</h6>
                               <%-- <p>
                                    magna aliqua
               
                                </p>--%>
                            </div>
                            <div class="img-box">
                                <img src="../TemplateFiles/images/anh2.png" alt="" class="box-img">
                            </div>
                        </div>
                    </div>
                     <div class="item">
                        <div class="box">
                            <div class="detail-box">
                                <p>
                                    "Tôi chưa từng ném món ly cafe nào ngon đến vậy.Nó có hương vị đặc trưng, thơm ngon và đậm đà.Thật may mắn khi tôi được thưởng thức. Thật tuyệt vời!"
               
                                </p>
                                <h6>Gordon Ramsay, 0/06/202</h6>
                               <%-- <p>
                                    magna aliqua
               
                                </p>--%>
                            </div>
                            <div class="img-box">
                                <img src="../TemplateFiles/images/anh3.png" alt="" class="box-img">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end client section -->

</asp:Content>
