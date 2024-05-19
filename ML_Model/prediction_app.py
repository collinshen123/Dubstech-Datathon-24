import streamlit as st
import pickle
import gzip

with gzip.open('trained_models.pkl', 'rb') as f:
    saved_data = pickle.load(f)

trained_models = saved_data['trained_models']
evaluation_metrics = saved_data['evaluation_metrics']
average_mae = saved_data['average_mae']
average_rmse = saved_data['average_rmse']
predictions_2026_01_01 = saved_data['predictions_2026_01_01']

model_names = list(trained_models.keys())

def predict_and_evaluate(model_name):
    trained_model = trained_models[model_name]
    evaluation_metric = evaluation_metrics[model_name]
    prediction = predictions_2026_01_01[model_name]
    return prediction, evaluation_metric



def main():
    st.title('Port Prediction App')
    st.subheader('CD Consulting inc.')
    st.write('')

    st.sidebar.image('port_map.jpeg')

    selected_model = st.selectbox('Select Port of Entry Model', sorted(model_names))
    

    if st.button('Predict Value'):
        
        prediction, evaluation_metric = predict_and_evaluate(selected_model)
        st.markdown(f"<h3 style='text-decoration: underline;'>Predicted value for {selected_model} in 2026: {round(prediction, 2)} people</h3>", unsafe_allow_html=True)
        st.write('')
            
        st.subheader('Model Evaluation Metrics')
        st.write(f"Average Mean Absolute Error across all ports: {round(average_mae, 2)}")
        st.write(f"Average Root Mean Squared Error across all ports: {round(average_rmse, 2)}")
        st.write('')
        
        
        st.write(f"Mean Absolute Error for {selected_model}: {round(evaluation_metrics[selected_model]['MAE'], 2)}")
        st.write(f"Root Mean Squared Error for {selected_model}: {round(evaluation_metrics[selected_model]['RMSE'], 2)}")
        


if __name__ == '__main__':
    main()