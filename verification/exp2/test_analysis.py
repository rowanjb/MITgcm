from xmitgcm import open_mdsdataset
data_dir = 'run'
ds = open_mdsdataset(data_dir,iters=[24])#,read_grid=False,nx=100,ny=100,nz=50)#,extra_variables=dict(ADJtheta=dict(dims=['k','j','i'], attrs=dict(standard_name='Sensitivity_to_theta', long_name='Sensitivity of cost function to theta', units='[J]/degC'))))
print(ds)
