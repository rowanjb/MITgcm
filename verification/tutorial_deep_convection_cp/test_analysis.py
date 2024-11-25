#https://matplotlib.org/stable/gallery/mplot3d/box3d.html#sphx-glr-gallery-mplot3d-box3d-py

from xmitgcm import open_mdsdataset 
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d
import xarray as xr
import numpy as np
data_dir = './run_serial'#global_oce_latlon'
ds = open_mdsdataset(data_dir,geometry='cartesian',prefix=['Eta'])

print(ds.i_g.to_numpy())#.XG.to_numpy())
quit()

ds['T'] = xr.where(ds.T<19.98,ds.Z,0)
ds['Depth ($m$)'] = ds.T.min(dim='Z')
for t in range(0,len(ds.time.to_numpy())):
    dst = ds.isel(time=t)
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')  
    dst['Depth ($m$)'].plot.surface(cmap='viridis',add_colorbar=False)
    hours = dst.time.dt.seconds.to_numpy()/360
    plt.title('T < 19.98$\degree$C - ' + str(hours) + ' hrs')
    plt.xlabel('$m$')
    plt.ylabel('$m$')
    ax.set_zlim(-1000, 0)
    plt.savefig('plume_figs_0c/plume_'+str(t)+'.png', dpi=900, bbox_inches="tight", pad_inches = 0.5)
    plt.clf()
quit()

#t=20 

#fig = plt.figure(figsize=(5, 4))
#ax = fig.add_subplot(111, projection='3d')

#X, Y, Z = ds.XC.to_numpy(), ds.YC.to_numpy(), ds.Z.to_numpy()
#ds['T'] = ds.T.transpose('time','XC','YC','Z')

# Plot contour surfaces
#_ = ax.contourf(                                           
#    X, Y, ds.T.isel(time=t,Z=0).to_numpy(),
#    zdir='z', offset=0 #offset should really be -10
#)

## Set zoom and angle view
#ax.view_init(40, -30, 0)
#ax.set_box_aspect(None, zoom=0.9)

# Show Figure
#fig.savefig('testFig.png', dpi=900, bbox_inches="tight", pad_inches = 0.5)
#fig.clf()

#quit()

# Define dimensions
Nx, Ny, Nz = 100, 300, 500
X, Y, Z = np.meshgrid(np.arange(Nx), np.arange(Ny), -np.arange(Nz))

# Create fake data
data = (((X+100)**2 + (Y-20)**2 + 2*Z)/1000+1)

kw = {
    'vmin': data.min(),
    'vmax': data.max(),
    'levels': np.linspace(data.min(), data.max(), 10),
}

# Create a figure with 3D ax
fig = plt.figure(figsize=(5, 4))
ax = fig.add_subplot(111, projection='3d')

# Plot contour surfaces
_ = ax.contourf(
    X[:, :, 0], Y[:, :, 0], data[:, :, 0],
    zdir='z', offset=0, **kw
)
_ = ax.contourf(
    X[0, :, :], data[0, :, :], Z[0, :, :],
    zdir='y', offset=0, **kw
)
C = ax.contourf(
    data[:, -1, :], Y[:, -1, :], Z[:, -1, :],
    zdir='x', offset=X.max(), **kw
)
# --


# Set limits of the plot from coord limits
xmin, xmax = X.min(), X.max()
ymin, ymax = Y.min(), Y.max()
zmin, zmax = Z.min(), Z.max()
ax.set(xlim=[xmin, xmax], ylim=[ymin, ymax], zlim=[zmin, zmax])

# Plot edges
edges_kw = dict(color='0.4', linewidth=1, zorder=1e3)
ax.plot([xmax, xmax], [ymin, ymax], 0, **edges_kw)
ax.plot([xmin, xmax], [ymin, ymin], 0, **edges_kw)
ax.plot([xmax, xmax], [ymin, ymin], [zmin, zmax], **edges_kw)

# Set labels and zticks
ax.set(
    xlabel='X [km]',
    ylabel='Y [km]',
    zlabel='Z [m]',
    zticks=[0, -150, -300, -450],
)

# Show Figure
plt.savefig('testFig.png', dpi=900, bbox_inches="tight", pad_inches = 0.5)
plt.clf()

quit()




















t = 20

## Define dimensions
#Nx, Ny, Nz = 100, 300, 500
#X, Y, Z = np.meshgrid(np.arange(Nx), np.arange(Ny), -np.arange(Nz))
#
## Create fake data
#data = (((X+100)**2 + (Y-20)**2 + 2*Z)/1000+1)

# Define dimensions
X, Y, Z = ds.XC.to_numpy(), ds.YC.to_numpy(), ds.Z.to_numpy()

# Keywords
data = ds.T.isel(time=t).to_numpy()
kw = {
    'vmin': data.min(),
    'vmax': data.max(),
    'levels': np.linspace(data.min(), data.max(), 10),
}

# Create a figure with 3D ax
fig = plt.figure(figsize=(5, 4))
ax = fig.add_subplot(111, projection='3d')

ds['T'] = ds.T.transpose('time','XC','YC','Z')

# Plot contour surfaces
_ = ax.contourf(                                           
    X, Y, ds.T.isel(time=t,Z=0).to_numpy(),
    zdir='z', offset=0, **kw #offset should really be -10
)
_ = ax.contourf(
    X, ds.T.isel(time=t,YC=0).to_numpy(), Z,
    zdir='y', offset=0, **kw #offset should really be 10
)
C = ax.contourf(
    ds.T.isel(time=t,XC=0).to_numpy(), Y, Z,
    zdir='x', offset=X.max(), **kw
)
# --

# Set limits of the plot from coord limits
xmin, xmax = X.min(), X.max()
ymin, ymax = Y.min(), Y.max()
zmin, zmax = Z.min(), Z.max()
ax.set(xlim=[xmin, xmax], ylim=[ymin, ymax], zlim=[zmin, zmax])

# Plot edges
edges_kw = dict(color='0.4', linewidth=1, zorder=1e3)
ax.plot([xmax, xmax], [ymin, ymax], 0, **edges_kw)
ax.plot([xmin, xmax], [ymin, ymin], 0, **edges_kw)
ax.plot([xmax, xmax], [ymin, ymin], [zmin, zmax], **edges_kw)

# Set labels and zticks
ax.set(
    xlabel='X [km]',
    ylabel='Y [km]',
    zlabel='Z [m]'#,
    #zticks=[0, -150, -300, -450],
)

# Set zoom and angle view
ax.view_init(40, -30, 0)
ax.set_box_aspect(None, zoom=0.9)

# Colorbar
fig.colorbar(C, ax=ax, fraction=0.02, pad=0.1, label='Name [units]')

# Show Figure
plt.savefig('parallel_t3602', dpi=900, bbox_inches="tight")
plt.clf()


#for i in list(ds.coords):
#    print(i)
#    print(ds[i].attrs)
#    print(ds[i])
#quit()

##times = ds.time.to_numpy()
#T = ds.T.isel(time=2,YC=50)
#T.plot.contourf(
#    x='XC',
#    y='Z',
#    cmap='viridis')
#plt.title('Cross section 1')
#plt.xlabel('Horizontal (cells)')
#plt.ylabel('Depth (cells)')
#plt.savefig('parallel_t3602', dpi=900, bbox_inches="tight")
#plt.clf()
#quit()

