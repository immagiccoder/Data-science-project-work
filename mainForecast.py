import numpy as np
import pandas as pd

from PIL import Image
import matplotlib.pyplot as plt
# import seaborn as sns
import statsmodels.api as sm
import plotly.tools as tls
from plotly import subplots
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st


st.set_page_config(layout="wide")


def load_data():
    data = pd.read_csv("airline_traffic.csv")
    data.columns = ["Date", "Passengers"]
    return data

def plot_decomposition(data):
    decomposition = sm.tsa.seasonal_decompose(data.Passengers, model='additive')
    fig = subplots.make_subplots(
        rows=4, cols=1,
        subplot_titles=["Observed", "Trend", "Seasonal", "Residuals"],
        shared_xaxes=True)

    fig.add_trace(
        go.Scatter(
            x=decomposition.seasonal.index, y=decomposition.observed,
            mode='lines', legendgroup="observed", name="observed"
        ),
        row=1, col=1
    )

    fig.add_trace(
        go.Scatter(
            x=decomposition.trend.index, y=decomposition.trend,
            mode='lines', legendgroup="trend", name="trend"
        ),
        row=2, col=1
    )

    fig.add_trace(
        go.Scatter(
            x=decomposition.seasonal.index, y=decomposition.seasonal,
            mode='lines', legendgroup="seasonality", name="seasonality"
        ),
        row=3, col=1
    )

    fig.add_trace(
        go.Scatter(
            x=decomposition.resid.index, y=decomposition.resid,
            mode='markers', legendgroup = "residuals", name="residuals"
        ),
        row=4, col=1
    )
    fig.update_layout(height=600, width=1000)

    return fig

def main():
    # -------------------------------- header -------------------------------- #
    st.title("Forecasting values of Time series data")
    st.subheader("Predicting future values to take decisions ahead of time")

    # ------------------------------ about data ----------------------------- #
    st.write("Here the Time series forecasting is done on the data of Airline Passengers Traffic")

    # ----------------------------- loading data ----------------------------- #
    data = load_data()

    # ------------------------------ data sample ----------------------------- #
    st.write("## A look at some data samples")
    st.dataframe(data.sample(5).reset_index(drop=True))
    data.loc[:, 'Date'] = pd.to_datetime(data['Date'])

    # ------------------------------- data plot ------------------------------ #
    st.write("## Visuals of the data")
    plot_cols = st.columns(5)
    fig = px.line(data, x="Date", y="Passengers")
    fig.update_layout(autosize=True, margin=dict(l=20, r=0, t=20, b=20))
    plot_cols[1].plotly_chart(fig)

    # ------------------------------ description ----------------------------- #
    st.write("### Data distribution")
    st.write("Here we can see the value ranges from 100 - 600, with more values near 200 and mean of distribution near 250")
    dist_cols = st.columns(2)
    dist_cols[1].dataframe(data.describe())
    dist_cols[0].image(Image.open('distribution.png'), width=400)

    # ----------------------------- decomposition ---------------------------- #
    st.write("### Decomposing time series")
    st.write("The time series is decomposed into trend and seasonality patters")
    st.write("> We can see a trend going up and repeating seasonal patterns after every 12 Month period")
    data = data.set_index(['Date'])
    st.plotly_chart(plot_decomposition(data))

    # ------------------------------- modeling ------------------------------- #
    st.write("## Modeling methods")

    # ---------------------------------- sma --------------------------------- #
    st.write("### Simple Moving Average")
    st.write("A simple moving average (SMA) is an arithmetic moving average calculated by adding recent values and then dividing that figure by the number of time periods in the calculation average.")
    st.write("> Below is an example where no. of time periods used(window size) is 6, which here means a Quater of year")
    sma_cols = st.columns(4)
    sma_cols[1].image(Image.open('sma_forecast.png'), width=600)
    st.write("Here, we can see that the moving average at the last time step is interpolated at next timesteps, therefore SMA can only gives us a baseline with which we compare other methods")
    st.markdown("**Results:**")
    st.dataframe(pd.DataFrame({"Mean absolute percentage error":[14.71], "Root Mean squared Error":[95.06]}, index=["Error"]))

    # --------------------------------- lstm --------------------------------- #
    st.write("### Deep Learning | LSTM")
    st.write("The Long Short-Term Memory network, or LSTM network, is a recurrent neural network that can be used to address difficult sequence problems in machine learning.")
    lstm_net_cols = st.columns(4)
    lstm_net_cols[1].image(Image.open('lstm_network.png'), width=500)
    st.write("> We run training for n number of iterations, in each iteration model learns from complete data sequences")
    st.write("> Below we can see, how with each iteration the model is learning well and the loss is decreasing on validation data on which training is not performed")
    st.image(Image.open('lstm_metrics.png'), width=400)
    st.markdown("**Results:**")
    lstm_cols = st.columns(4)
    lstm_cols[1].image(Image.open('lstm_forecast.png'), width=600)
    st.dataframe(pd.DataFrame({"Mean absolute percentage error":[10.11], "Root Mean squared Error":[57.39]}, index=["Error"]))


if __name__ == '__main__':
    main()