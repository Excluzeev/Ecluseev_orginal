<template>
	<div id="my_ernings_page">

		<div class="container-fluid">
			<div class="row">
				<div class="col-xl-12 ">
					<div class="list-inline my_ernings_title_section d-xl-none d-none d-lg-block d-xl-block">
						<div class="pull-left">
							<h2>My earnings</h2>
							<p>Earnings from all the communities</p>
						</div>
						<div class="pull-right total_erning_section">
							<h3><span>Total earnings&nbsp;&nbsp;&nbsp;$ 532</span></h3>
							<button class="btn btn-withdraw-amount">Withdraw amount</button>
						</div>
						<div class="clearfix"></div>
					</div>	
					<div class="form-group offset-2 col-8  d-block d-xl-none d-lg-none">
						<br>
					    <select class="form-control" id="exampleFormControlSelect1">
					      <option selected="selected">Bri n Teesh</option>
					      <option>Bri n Teesh</option>
					      <option>Bri n Teesh</option>
					      <option>Bri n Teesh</option>
					    </select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class=" col-xs-12 col-sm-12 col-md-12 col-lg-3 col-xl-3 left_tabs_panel d-xl-none d-none d-lg-block d-xl-block">

					<div class="nav flex-column nav-pills table_owner" id="v-pills-tab" role="tablist" aria-orientation="vertical">

						<a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">Bri N Teesh</a>
						<a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">Positivity Picasso &nbsp;&nbsp;&nbsp;<span>$ 137.82</span></a>
						<a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">Emperor Machina &nbsp;&nbsp;&nbsp;<span>$ 120.00</span></a>
						
					</div>
				</div>
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-9 col-xl-9 tab_content_panel">
					<div class="tab-content " id="v-pills-tabContent">
						<div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
							<div class="pull-right table_price d-xl-none d-none d-lg-block d-xl-block">
								<h3><span>Total&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;$10</span></h3>
							</div>
							<table class="table table-borderless">
								<thead>
									<tr>
										<th scope="col"><h3><span>Date</span></h3></th>
										<th scope="col"><h3><span>Name</span></h3></th>
										<th scope="col"><h3><span>Amount</span></h3></th>
										<th scope="col"><h3><span>Status</span></h3></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>21-2-20</td>
										<td>Chriss Joy</td>
										<td>$ 10</td>
										<td>Received</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Katie Pose</td>
										<td>$ 130</td>
										<td>Withdrawn</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Jeremiah Stillow</td>
										<td>$ 130</td>
										<td>Received</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Chriss Joy</td>
										<td>$ 10</td>
										<td>Received</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Katie Pose</td>
										<td>$ 130</td>
										<td>Withdrawn</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Jeremiah Stillow</td>
										<td>$ 130</td>
										<td>Received</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Chriss Joy</td>
										<td>$ 10</td>
										<td>Received</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Katie Pose</td>
										<td>$ 130</td>
										<td>Withdrawn</td>
									</tr>
									<tr>
										<td>21-2-20</td>
										<td>Jeremiah Stillow</td>
										<td>$ 130</td>
										<td>Received</td>
									</tr>
								</tbody>
							</table>
							<div class="text-center">
								<button class="btn btn-load-more">Load more</button>
							</div>
						</div>
						<div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">...</div>
						<div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">...</div>
						
					</div>
				</div>
			</div>
			
		</div>

    </div>
</template>

<script>
  export default {
    name: "MyEarnings"
  };
</script>

<style scoped>

</style>
